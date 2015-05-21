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

@interface SearchViewController ()

@property (nonatomic, strong) SearchViewModel *vm;

@end

@implementation SearchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _vm = [[SearchViewModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setBackgroundColor:[UIColor greenColor]];
    return cell;
    
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


#pragma mark SuggestionsViewControllerDelegate
-(void)suggestionsViewController:(SuggestionsViewController *)suggestionsViewController didSelectSuggestion:(NSString *)suggestion{

    [self.vm setQuery:suggestion];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    NSString *text = searchBar.text;
    [self.vm setQuery:text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
