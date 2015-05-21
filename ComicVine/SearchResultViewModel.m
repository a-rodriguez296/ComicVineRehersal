//
//  SearchResultViewModel.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/19/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchResultViewModel.h"

@implementation SearchResultViewModel

-(instancetype) initWithImageUrl:(NSURL *) url title:(NSString *) title publisher:(NSString *) publisher{
    if (self = [super init]) {
        _imageUrl = url;
        _title = title;
        _publisher = publisher;
    }
    return self;
}

@end
