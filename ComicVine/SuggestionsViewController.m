//
//  SuggestionsViewController.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "SuggestionsViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const reuseIdentifier = @"SuggestionCell";

@interface SuggestionsViewController ()

@property (nonatomic, strong) SuggestionsViewModel *viewModel;

@end

@implementation SuggestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [SuggestionsViewModel new];
    
    @weakify(self);
    [self.viewModel.didUpdateSuggestionsSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        
    }];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.viewModel.numberOfSuggestions;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell.textLabel setText:[self.viewModel suggestionsAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *suggestion = [self.viewModel suggestionsAtIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate suggestionsViewController:self didSelectSuggestion:suggestion];
    }
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    self.viewModel.query = searchController.searchBar.text;
}

@end
