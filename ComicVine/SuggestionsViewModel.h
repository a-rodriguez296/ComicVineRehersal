//
//  SuggestionsViewModel.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  RACSignal;

@interface SuggestionsViewModel : NSObject

@property (nonatomic, copy) NSString *query;
@property (nonatomic, readonly) NSUInteger numberOfSuggestions;

//Señal con la que se va a transimitir el evento de que las sugerencias han cambiado. 
@property (nonatomic, strong, readonly) RACSignal * didUpdateSuggestionsSignal;


-(NSString *) suggestionsAtIndex:(NSUInteger ) index;


@end
