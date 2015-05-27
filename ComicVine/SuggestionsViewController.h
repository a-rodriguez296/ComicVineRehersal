//
//  SuggestionsViewController.h
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuggestionsViewControllerDelegate;


@interface SuggestionsViewController : UITableViewController <UISearchResultsUpdating> 

@property(nonatomic, weak) id<SuggestionsViewControllerDelegate> delegate;

@end

@protocol SuggestionsViewControllerDelegate <NSObject>

-(void) suggestionsViewController:(SuggestionsViewController *) viewController didSelectSuggestion:(NSString *) suggestion;

@end

