//
//  popViewController.m
//  iphonsamples
//
//  Created by Optimind on 8/12/13.
//  Copyright (c) 2013 Optimind. All rights reserved.
//

#import "popViewController.h"

@interface popViewController (){
    IBOutlet UITableView *sampleTableView;
    
    NSArray *items;
    BOOL isSearching;
    
    NSMutableArray *filteredList;
}

@end

@implementation popViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    isSearching = NO;
    filteredList = [[NSMutableArray alloc] init];
    items = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", @"four", @"xxxx", @"xxxxxyyy", nil];
    // Do any additional setup after loading the view from its nib.
}
- (void)filterListForSearchText:(NSString *)searchText
{
    NSLog(@"filterListForSearchText");
    [filteredList removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    
    for (NSString *title in items) {
        NSRange nameRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [filteredList addObject:title];
        }
    }
}
#pragma mark UISearchDisplay Delegates
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //When the user taps the search bar, this means that the controller will begin searching.
    NSLog(@"searchDisplayControllerWillBeginSearch");
    isSearching = YES;
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    NSLog(@"searchDisplayControllerWillEndSearch");
    //When the user taps the Cancel Button, or anywhere aside from the view.
    isSearching = NO;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"searchDisplayController");
    [self filterListForSearchText:[self.searchDisplayController.searchBar text]]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - UITableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (isSearching) {
        //If the user is searching, use the list in our filteredList array.
        return [filteredList count];
    } else {
        return [items count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *title;
    if (isSearching && [filteredList count]) {
        //If the user is searching, use the list in our filteredList array.
        title = [filteredList objectAtIndex:indexPath.row];
    } else {
        title = [items objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = title;
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
