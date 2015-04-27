//
//  MainTableViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "MainTableViewController.h"

#import "DetailViewController.h"
#import "ResultsTableViewController.h"
#import "Building.h"
#import "ViewController.h"
@interface MainTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) ResultsTableViewController *resultsTableController;


@end


#pragma mark -


@implementation MainTableViewController
-(NSString *) filePath {
    // NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //return [[paths objectAtIndex: 0] stringByAppendingPathComponent:@"Warframe.sqlite"];
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSLog(@"%@", mainBundle);
    NSString * myFile = [mainBundle pathForResource: @"Buildings" ofType: @"sqlite"];
    NSLog(@"%@", myFile);
    return myFile;

}
-(void) openDB{
    if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open");
    }
    else{
        NSLog(@"Database opened");
    }
}



- (void)viewDidLoad {
    //[super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    NSArray * BuildingsArray = [[BuildingStore defaultStore] allBuildings];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Buildings"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) ==SQLITE_OK)
    {
        int i = 0;
        while(sqlite3_step(statement)==SQLITE_ROW){
            NSString *field2Str;
            NSString *field5Str;
            NSString *field6Str;
            NSString *field7Str;
            char *field1 = (char *) sqlite3_column_text(statement,0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            char *field2 = (char *) sqlite3_column_text(statement,1);
            if(field2 == NULL)
            {
                field2Str = @"NULL";
            }
            else{
                field2Str = [[NSString alloc] initWithUTF8String:field2];
            }
            
            double field3 = (double) sqlite3_column_double(statement,1);
//            double field3Str = [[double alloc] initWithUTF8String:field3];
            double field4 = (double) sqlite3_column_double(statement,1);
//            double *field4Str = [[NSString alloc] initWithUTF8String:field4];
            char *field5 = (char *) sqlite3_column_text(statement,1);
            if(field5 == NULL)
            {
                field5Str = @"NULL";
            }
            else{
                field5Str = [[NSString alloc] initWithUTF8String:field2];
            }
            char *field6 = (char *) sqlite3_column_text(statement,1);
            if(field6 == NULL)
            {
                field6Str = @"NULL";
            }
            else{
                field6Str = [[NSString alloc] initWithUTF8String:field2];
            }
            char *field7 = (char *) sqlite3_column_text(statement,1);
            if(field7 == NULL)
            {
                field7Str = @"NULL";
            }
            else{
                field7Str = [[NSString alloc] initWithUTF8String:field2];
            }
            
            
            
            
            
            [[BuildingStore defaultStore] createBuildingName:(NSString *) field1Str
                                            BuildingNickName:(NSString *) field2Str
                                            BuildingLatitude:(double ) field3
                                           BuildingLongitude:(double ) field4
                                                 BuildingUrl:(NSString *) field5Str
                                                BuildingType:(NSString *) field6Str
                                               BuildingHours:(NSString *) field7Str];
            NSLog(@"Building Name : %@  BuildingNickName: %i", field1Str, i++);
            //NSLog(@"Building Name :   Rarity: ");
            
        }
    }
    [super viewDidLoad];
    
    _resultsTableController = [[ResultsTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
    
    
    //sqlite3_close(db);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchController.searchBar becomeFirstResponder];
}
-(void) viewWillAppear:(BOOL)animated{
    self.searchController.active = TRUE;
    [self.searchController becomeFirstResponder];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"cat");
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    ViewController * rootViewControllerPointer =  (ViewController*) (self.navigationController.viewControllers[0]);
//    rootViewControllerPointer.isSearch = true;
 //   rootViewControllerPointer.searchedBuilding = self.pickedBuilding;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Count = %lu",(unsigned long)[[[BuildingStore defaultStore] allBuildings] count]);
    return [[[BuildingStore defaultStore] allBuildings] count];
}

#pragma mark - UITableViewDelegate

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Building *building = [[[BuildingStore defaultStore] allBuildings]
                          objectAtIndex:[indexPath row]];

    [self configureCell:cell forBuilding:building];
    
    return cell;
}

// here we are the table view delegate for both our main table and filtered table, so we can
// push from the current navigation controller (resultsTableController's parent view controller
// is not this UINavigationController)
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Building *selectedBuilding = (tableView == self.tableView) ?
    [[[BuildingStore defaultStore] allBuildings]
     objectAtIndex:[indexPath row]] : self.resultsTableController.filteredBuildings[indexPath.row];
    
    NSLog(@"Cell Name CLicked = %@", selectedBuilding.buildingName);
    ViewController * rootViewControllerPointer =  (ViewController*) (self.navigationController.viewControllers[0]);
    rootViewControllerPointer.isSearch = true;
    rootViewControllerPointer.searchedBuilding = selectedBuilding;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    
    // Remove all objects from the filtered search array
    //[self.filteredCandyArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.buildingName contains[c] %@",searchText];
    NSArray *tempArray =  [[[[BuildingStore defaultStore] allBuildings] mutableCopy] filteredArrayUsingPredicate:predicate];
    

    NSArray * searchResults = [NSMutableArray arrayWithArray:tempArray];
    // hand over the filtered results to our search results table
    ResultsTableViewController *tableController = (ResultsTableViewController *)self.searchController.searchResultsController;
    tableController.filteredBuildings = searchResults;
    //[self.searchController.searchBar becomeFirstResponder];
    [tableController.tableView reloadData];
}








@end
