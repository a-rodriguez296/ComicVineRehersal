//
//  SuggestionsViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SuggestionsViewModel.h"
#import "ComicVineClient.h"
#import "Response.h"
#import "Volume.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface SuggestionsViewModel ()


@property (nonatomic, copy) NSArray *suggestions;

@end

@implementation SuggestionsViewModel


- (instancetype)init
{
    if (self == [super init]){
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
    
    @weakify(self);
    RACSignal *suggestionsSignal = [input flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self fetchSuggestionsWithQuery:self.query];
    }];
    
    
    RAC(self, suggestions) = [suggestionsSignal catch:^RACSignal *(NSError *error) {
        return nil;
    }];
    
    
    _didUpdateSuggestionsSignal = RACObserve(self, suggestions);
}


-(RACSignal *) fetchSuggestionsWithQuery:(NSString *) query{
    ComicVineClient *client = [ComicVineClient new];
    return [[client fetchSuggestedVolumesWithQuery:query] map:^id(Response *response) {
        
        NSMutableArray *responseArray = [NSMutableArray array];
        for (Volume *volume in response.results) {
            if ([responseArray containsObject:volume.title]) {
                continue;
            }
            [responseArray addObject:volume.title];
        }
        return responseArray;
    }];
}

@end
