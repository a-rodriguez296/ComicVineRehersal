//
//  SearchViewController.m
//  ComicVine
//
//  Created by Alejandro Rodriguez on 5/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "SearchViewController.h"
#import "SuggestionsViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:suggestionsVC];
    [searchController setSearchResultsUpdater:suggestionsVC];
    [searchController setHidesNavigationBarDuringPresentation:NO];
    
    
    
    [self presentViewController:searchController animated:YES completion:nil];
}

@end