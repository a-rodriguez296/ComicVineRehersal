//
//  SearchResultCell.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultsViewModel;

@interface SearchResultCell : UITableViewCell



-(void) configureWithSearchResult:(SearchResultsViewModel *) searchResult;
@end
