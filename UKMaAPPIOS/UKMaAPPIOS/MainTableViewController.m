//
//  MainTableViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

/*
 Abstract:
 Class file to implement the MainTableView for the search function. This controller is the first table view the users see after clicking on the search button in the app. It loads, stores, and displayes the building information into a table view. This controller is also resposible for UISearchController protocols, and is the delegate and datasource, updatesource for the searched data.
 
 */
#import "MainTableViewController.h"
#import "ResultsTableViewController.h"
#import "Building.h"
#import "ViewController.h"
@interface MainTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) ResultsTableViewController *resultsTableController;
@property (nonatomic) NSMutableArray * searchedBuildingResults;

@end


#pragma mark -


@implementation MainTableViewController
//Gets filepath to database.
-(NSString *) filePath {
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSLog(@"%@", mainBundle);
    NSString * myFile = [mainBundle pathForResource: @"Buildings" ofType: @"sqlite"];
    NSLog(@"%@", myFile);
    return myFile;

}
//Opens database
-(void) openDB{
    if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open");
    }
    else{
        NSLog(@"Database opened");
    }
}


//Called when screen is loaded into view.
- (void)viewDidLoad {
    [[BuildingStore defaultStore] clearStore];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT Name,NickName, Latitude, Longitude, Url, Type, Hours FROM Buildings"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) ==SQLITE_OK)
    {
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
            
            double field3 = (double) sqlite3_column_double(statement,2);
            //            double field3Str = [[double alloc] initWithUTF8String:field3];
            double field4 = (double) sqlite3_column_double(statement,3);
            //            double *field4Str = [[NSString alloc] initWithUTF8String:field4];
            char *field5 = (char *) sqlite3_column_text(statement,4);
            if(field5 == NULL)
            {
                field5Str = @"NULL";
            }
            else{
                field5Str = [[NSString alloc] initWithUTF8String:field5];
            }
            char *field6 = (char *) sqlite3_column_text(statement,5);
            if(field6 == NULL)
            {
                field6Str = @"NULL";
            }
            else{
                field6Str = [[NSString alloc] initWithUTF8String:field6];
            }
            char *field7 = (char *) sqlite3_column_text(statement,6);
            if(field7 == NULL)
            {
                field7Str = @"NULL";
            }
            else{
                field7Str = [[NSString alloc] initWithUTF8String:field7];
            }
            
            
            
            
            
            
            [[BuildingStore defaultStore] createBuildingName:(NSString *) field1Str
                                            BuildingNickName:(NSString *) field2Str
                                            BuildingLatitude:(double ) field3
                                           BuildingLongitude:(double ) field4
                                                 BuildingUrl:(NSString *) field5Str
                                                BuildingType:(NSString *) field6Str
                                               BuildingHours:(NSString *) field7Str];
                        
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
    
    
    sqlite3_close(db);
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
    ViewController * rootViewControllerPointer =  (ViewController*) (self.navigationController.viewControllers[0]);
    rootViewControllerPointer.isSearch = true;

    rootViewControllerPointer.searchedBuildingResults = self.searchedBuildingResults;
    [[BuildingStore defaultStore] clearStore];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
    [[BuildingStore defaultStore] clearStore];
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
    
    NSLog(@"Cell Name CLicked = %@, Latitdue = %f", selectedBuilding.buildingName, selectedBuilding.buildingLongitude);
    ViewController * rootViewControllerPointer =  (ViewController*) (self.navigationController.viewControllers[0]);
    rootViewControllerPointer.isSearch = true;
    NSMutableArray * tempArray = [NSMutableArray arrayWithObject:selectedBuilding];
    rootViewControllerPointer.searchedBuildingResults = tempArray;
    [[BuildingStore defaultStore] clearStore];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text

    // Filter the array using NSPredicate
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.buildingName contains[c] %@",searchText];
    NSArray *tempArray =  [[[[BuildingStore defaultStore] allBuildings] mutableCopy] filteredArrayUsingPredicate:predicate];
    //Temp array is to store objects that match search string with building name.
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF.buildingNickName contains[c] %@",searchText];
    NSArray *tempArray2 = [[[[BuildingStore defaultStore] allBuildings] mutableCopy] filteredArrayUsingPredicate:predicate2];
    //tempArray2  is to store objects that match search string with buidling Nick Name.
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF.buildingType contains[c] %@",searchText];
    NSArray *tempArray3 = [[[[BuildingStore defaultStore] allBuildings] mutableCopy] filteredArrayUsingPredicate:predicate3];
    //tempArray3 is to store objects that match search string with building categories/types.
    //Used sets to join arrays together and remove duplicate objects.
    NSSet *firstSet= [NSSet setWithArray:tempArray];
    NSSet *secondSet= [NSSet setWithArray:tempArray2];
    NSSet *thirdSet = [NSSet setWithArray:tempArray3];
    
    NSMutableSet *unionFirstSecondSet=[NSMutableSet new];
    [unionFirstSecondSet unionSet:firstSet];
    [unionFirstSecondSet unionSet:secondSet];
    
    NSMutableSet *unionFirstSecondThirdSet=[NSMutableSet new];
    [unionFirstSecondThirdSet unionSet:unionFirstSecondSet];
    [unionFirstSecondThirdSet unionSet:thirdSet];
    
    self.searchedBuildingResults = [NSMutableArray array];
    
    [self.searchedBuildingResults addObjectsFromArray:[unionFirstSecondThirdSet allObjects]];
    
    // hand over the filtered results to our search results table
    ResultsTableViewController *tableController = (ResultsTableViewController *)self.searchController.searchResultsController;
    tableController.filteredBuildings = self.searchedBuildingResults;
    //[self.searchController.searchBar becomeFirstResponder];
    [tableController.tableView reloadData];
}








@end
