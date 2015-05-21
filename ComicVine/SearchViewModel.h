//
//  SearchViewModel.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchResultViewModel;
@class RACSignal;


@interface SearchViewModel : NSObject

@property (nonatomic, copy) NSString *query;

@property (nonatomic, readonly) NSUInteger numberOfResults;

//Señal con la que se va a transimitir el evento de los resultados han cambiado.
@property (nonatomic, strong, readonly) RACSignal * didUpdateResultsSignal;


-(SearchResultViewModel *) resultAtIndex:(NSUInteger ) index;


@end
