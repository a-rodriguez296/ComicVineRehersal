//
//  SearchResultViewModel.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultViewModel : NSObject

@property (nonatomic, copy, readonly) NSURL * imageUrl;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString * publisher;

-(instancetype) initWithImageUrl:(NSURL *) url title:(NSString *) title publisher:(NSString *) publisher;


@end
