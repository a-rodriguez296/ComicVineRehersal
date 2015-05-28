//
//  SearchResultCell.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchResultsViewModel.h"

#import <AFNetworking/UIKit+AFNetworking.h>

@interface SearchResultCell ()


@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;


@end


@implementation SearchResultCell


-(void) configureWithSearchResult:(SearchResultsViewModel *) searchResult{
    
    [self.coverImageView setImageWithURL:searchResult.imageURL];
    [self.titleLabel setText:searchResult.title];
    [self.publisherLabel setText:searchResult.subTitle];
}


-(void)prepareForReuse{
    
    [super prepareForReuse];
    [self.coverImageView cancelImageRequestOperation];
    self.coverImageView.image = nil;
}

@end
