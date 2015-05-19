//
//  SuggestionsViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SuggestionsViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ComicVineClient.h"


@interface SuggestionsViewModel ()


@property (nonatomic, copy) NSArray *suggestions;
@property (nonatomic, strong) ComicVineClient * client;

@end

@implementation SuggestionsViewModel


- (instancetype)init
{
    if (self == [super init]){
        _client = [[ComicVineClient alloc] init];
        [self setupSignals];
    }
    return self;
}



#pragma mark Public
-(NSString *)suggestionsAtIndex:(NSUInteger)index{
    return self.suggestions[index];
}

-(NSUInteger)numberOfSuggestions{
    return self.suggestions.count;
}


#pragma mark Private

-(void) setupSignals{
    
    //Crear una señal que observe el atributo query
    RACSignal *input = RACObserve(self, query);
    
    //Crear un filtro para que solo se mande la señal despues de 3 caracteres
    input = [input filter:^BOOL(NSString * value) {
        return value.length>2;
    }];
    
    //Crea un "filtro" para que solo se mande la señal después de 0.4 segundos de inactividad
    input = [input throttle:0.4];
    
    RACSignal *suggestionsSignal = [input flattenMap:^RACStream *(id value) {
        
        return [self fetchSuggestionsWithQuery:self.query];
    }];
    
    
    RAC(self, suggestions) = [suggestionsSignal catch:^RACSignal *(NSError *error) {
        return nil;
    }];
    
    
    _didUpdateSuggestionsSignal = RACObserve(self, suggestions);
}


-(RACSignal *) fetchSuggestionsWithQuery:(NSString *) query{
    
    return [self.client fetchSuggestedVolumeswithQuery:query];
}

@end
