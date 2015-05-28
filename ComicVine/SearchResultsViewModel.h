//
//  SearchResultsViewModel.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultsViewModel : NSObject



@property (nonatomic, copy, readonly) NSURL * imageURL;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString *subTitle;


-(instancetype) initWithImageURL:(NSURL *) imageURL title:(NSString *) title subtitle:(NSString *) subtitle;

@end
