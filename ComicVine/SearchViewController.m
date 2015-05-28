//
//  SearchViewController.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchViewController.h"
#import "SuggestionsViewController.h"
#import "SearchViewModel.h"
#import "SearchResultsViewModel.h"
#import "SearchResultCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SearchViewController () <UISearchBarDelegate,SuggestionsViewControllerDelegate>

@property(nonatomic, strong) SearchViewModel *viewModel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [SearchViewModel new];
    
    @weakify(self);
    [self.viewModel.didUpdateResults subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfResults];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    SearchResultsViewModel * searchResult = [self.viewModel resultAtIndex:indexPath.row];
    [cell configureWithSearchResult:searchResult];
    [cell setBackgroundColor:[UIColor greenColor]];
    return cell;
    
}

#pragma mark SuggestionsViewControllerDelegate
-(void)suggestionsViewController:(SuggestionsViewController *)viewController didSelectSuggestion:(NSString *)suggestion{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.viewModel setQuery:suggestion];

}

#pragma mark UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.viewModel setQuery:searchBar.text];
}

#pragma mark IBActions

- (IBAction)didTapSearch:(id)sender {
    
    
    SuggestionsViewController *suggestionsVC = [SuggestionsViewController new];
    [suggestionsVC setDelegate:self];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:suggestionsVC];
    [searchController setSearchResultsUpdater:suggestionsVC];
    [searchController setHidesNavigationBarDuringPresentation:NO];
    [searchController.searchBar setDelegate:self];
    
    
    [self presentViewController:searchController animated:YES completion:nil];
}

@end
