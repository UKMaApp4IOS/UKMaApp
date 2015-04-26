//
//  BuildingsTableViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/15/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "BuildingsTableViewController.h"
#import "BuildingDetailViewController.h"

@interface BuildingsTableViewController ()

@end

@implementation BuildingsTableViewController
BuildingDetailViewController *buildingDetailViewController = nil;

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
    
    NSArray * BuildingsArray = [[BuildingStore defaultStore] allBuildings];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT Name,NickName, Latitude, Longitude, Url, Type, Hours FROM Buildings WHERE Type = '%@'", self.pickedCategory];
    //sql = [sql stringByAppendingString:self.pickedCategory];
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
            NSLog(@"Building Name : %@  BuildingNickName: %@, BuildingLat: %f, BuildingLong: %f, building URL: %@, buildingType: %@, BuildingHours: %@ ", field1Str, field2Str, field3, field4, field5Str, field6Str, field7Str);
            //NSLog(@"Building Name :   Rarity: ");
            
        }
    }
    //NSLog(@"haha, %@", self.pickedCategory );
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [[[BuildingStore defaultStore] allBuildings] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     /*// Create an instance of UITableViewCell, with default appearance
     UITableViewCell *cell =
     [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:@"UITableViewCell"] ;
     */
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UIBuildingViewCell"];
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UIBuildingViewCell"];
    }
    // Set the text on the cell with the description of the possession
    // that is at the nth index of possessions, where n = row this cell
    // will appear in on the tableview
    Building *building = [[[BuildingStore defaultStore] allBuildings]
                          objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[building buildingName]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Building *selectedBuilding = [[[BuildingStore defaultStore] allBuildings] objectAtIndex:[indexPath row]];
    /*
     DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
     detailViewController.building = selectedBuilding; // hand off the current product to the detail view controller
     
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
     [tableView deselectRowAtIndexPath:indexPath animated:NO];*/
    NSLog(@"Name: %@, URL: %@, Hours: %@", selectedBuilding.buildingName, selectedBuilding.buildingUrl, selectedBuilding.buildingHours);
    buildingDetailViewController.pickedBuilding = selectedBuilding;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ( [[segue identifier] isEqualToString:@"buildingDetail"] ) {
        
        buildingDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller
        //categoryDetailViewController.pickedCategory = self.pickedCategory;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
        // View is disappearing because a new view controller was pushed onto the stack
        //NSLog(@"New view controller was pushed");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        // View is disappearing because it was popped from the stack
        //NSLog(@"View controller was popped");
        [[BuildingStore defaultStore] clearStore];
    }
    
}
@end
