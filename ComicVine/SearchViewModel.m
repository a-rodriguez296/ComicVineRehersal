//
//  SearchViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchResultViewModel.h"
#import "ComicVineClient.h"
#import "Response.h"
#import "Volume.h"
#import "ManagedVolume.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
@import CoreData;


@interface SearchViewModel ()

@property (nonatomic, strong) ComicVineClient *client;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, copy) NSMutableArray * volumes;


//Contexto de escritura
@property (nonatomic, strong) NSManagedObjectContext *privateContext;

//Contexto de lectura
@property (nonatomic, strong) NSManagedObjectContext *mainContext;


@end

@implementation SearchViewModel

- (instancetype)init
{
    if (self == [super init]) {
        _client = [[ComicVineClient alloc] init];
        _currentPage = 1;
        _volumes = [NSMutableArray array];
    }
    return self;
}


-(void)setQuery:(NSString *)query{
    if (![query isEqualToString:self.query]) {
        _query = [query copy];
        [self beginNewSearch];
    }
}

#pragma mark Private

-(void) beginNewSearch{
    
    self.currentPage = 1;
    
    NSManagedObjectContext *context = self.privateContext;
    [context performBlock:^{
        //Borrar la db antes de escribir volumenes nuevos
        
        [ManagedVolume deleteAllVolumesInManagedObjectContext:context];
        
    }];
    
    [[[self fetchNextPage]publish]connect];
}

-(RACSignal *) fetchNextPage{
    
    return [[[self.client fetchVolumesWithQuery:self.query page:self.currentPage++] doNext:^(Response *response) {
        
        //Guardar datos en Core Data
        
    }] deliverOnMainThread];
}


#pragma mark Public
-(SearchResultViewModel *) resultAtIndex:(NSUInteger ) index{
    
    return nil;
    
}



@end
