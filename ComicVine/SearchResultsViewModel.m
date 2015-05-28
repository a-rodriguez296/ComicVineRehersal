//
//  SearchResultsViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchResultsViewModel.h"

@implementation SearchResultsViewModel


-(instancetype) initWithImageURL:(NSURL *) imageURL title:(NSString *) title subtitle:(NSString *) subtitle{
    
    if (self = [super init]) {
        _imageURL = imageURL;
        _title = title;
        _subTitle = subtitle;
    }
    return self;
}

@end
