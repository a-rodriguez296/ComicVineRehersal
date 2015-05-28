//
//  SearchViewModel.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  SearchResultsViewModel;
@class RACSignal;


@interface SearchViewModel : NSObject


@property(nonatomic, copy) NSString *query;

@property(nonatomic, readonly) NSUInteger numberOfResults;

@property(nonatomic, strong, readonly) RACSignal * didUpdateResults;

-(SearchResultsViewModel *) resultAtIndex:(NSUInteger) index;

@end
