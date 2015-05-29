//
//  SearchViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchViewModel.h"
#import "ComicVineClient.h"
#import "SearchResultsViewModel.h"
#import "ManagedVolume.h"
#import "Response.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Groot/Groot.h>

@interface SearchViewModel () <NSFetchedResultsControllerDelegate>

@property(strong, nonatomic) ComicVineClient *client;
@property(nonatomic) NSUInteger currentPage;


@property (nonatomic, strong) GRTManagedStore *store;

//Contexto de escritura
@property(nonatomic, strong) NSManagedObjectContext *privateContext;

//Contexto de lectura
@property(nonatomic, strong) NSManagedObjectContext *mainContext;


@property (nonatomic, strong) NSFetchedResultsController *frc;

@end


@implementation SearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _client = [ComicVineClient new];
        _currentPage = 1;
        
        
        
        _store = [GRTManagedStore temporaryManagedStore];
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.persistentStoreCoordinator = _store.persistentStoreCoordinator;
        
        _privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _privateContext.persistentStoreCoordinator = _store.persistentStoreCoordinator;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(privateContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:_privateContext];
        
        
        _frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[ManagedVolume fetchRequestForAllVolumes] managedObjectContext:_mainContext sectionNameKeyPath:nil cacheName:nil];
        [_frc performFetch:NULL];
        [_frc setDelegate:self];
        
        _didUpdateResults = [self rac_signalForSelector:@selector(controllerDidChangeContent:)];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(NSUInteger)numberOfResults{
    return [self.frc.sections[0] numberOfObjects];
}

-(void)setQuery:(NSString *)query{
    if (![query isEqualToString:self.query]) {
        _query = [query copy];
        [self beginNewSearch];
    }
}


-(SearchResultsViewModel *) resultAtIndex:(NSUInteger) index{
    
    ManagedVolume *volume = [self.frc objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return  [[SearchResultsViewModel alloc] initWithImageURL:[NSURL URLWithString:volume.imageURL] title:volume.title subtitle:volume.publisher];
    
}

-(void) beginNewSearch{
    
    self.currentPage = 1;
    NSManagedObjectContext *context = self.privateContext;
    
    [context performBlock:^{
        [ManagedVolume deleteAllVolumesInManagedContext:context];
        [context save:NULL];
    }];
    
    [[[self fetchNextPage] publish] connect];
}

-(RACSignal *) fetchNextPage{
    
     NSManagedObjectContext *context = self.privateContext;
    
    return [[[self.client fetchVolumeWithQuery:self.query page:self.currentPage++] doNext:^(Response * response) {
        
        [GRTJSONSerialization insertObjectsForEntityName:[ManagedVolume entityName]fromJSONArray:response.results inManagedObjectContext:context error:NULL];
        
        [context performBlockAndWait:^{
            [context save:NULL];
        }];
        
    }] deliverOnMainThread];
}


-(void) privateContextDidSave:(NSNotification *) notification{
    
    //Acá se debe hacer el merge del contexto privado con el contexto del main thread
    NSManagedObjectContext *context = self.mainContext;
    
    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:notification];
    }];
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
}

@end
