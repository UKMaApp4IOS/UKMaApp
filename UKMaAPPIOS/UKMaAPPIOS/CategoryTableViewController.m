//
//  CategoryTableViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/15/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "BuildingsTableViewController.h"
@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController
BuildingsTableViewController *categoryDetailViewController = nil;
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
    self.navigationItem.title = @"Categories";
    NSArray * BuildingsArray = [[BuildingStore defaultStore] allBuildings];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT Type FROM Buildings"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) ==SQLITE_OK)
    {
        int i = 0;
        NSMutableArray *tempCategory = [[NSMutableArray alloc] init];
        while(sqlite3_step(statement)==SQLITE_ROW){
            /*NSString *field2Str;
            NSString *field5Str;
            NSString *field6Str;
            NSString *field7Str;*/
            char *field1 = (char *) sqlite3_column_text(statement,0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            NSLog(@"%@",field1Str);
            /*char *field2 = (char *) sqlite3_column_text(statement,1);
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
            */
            
            
            [tempCategory addObject:field1Str];
            /*
            [[BuildingStore defaultStore] createBuildingName:(NSString *) field1Str
                                            BuildingNickName:(NSString *) field2Str
                                            BuildingLatitude:(double ) field3
                                           BuildingLongitude:(double ) field4
                                                 BuildingUrl:(NSString *) field5Str
                                                BuildingType:(NSString *) field6Str
                                               BuildingHours:(NSString *) field7Str];*/
            //NSLog(@"Building Name : %@  BuildingNickName: %i", field1Str, i++);
            //NSLog(@"Building Name :   Rarity: ");
            
        }
        self.categories = tempCategory;
        [[BuildingStore defaultStore] clearStore];
        
    }


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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*// Create an instance of UITableViewCell, with default appearance
     UITableViewCell *cell =
     [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:@"UITableViewCell"] ;
     */
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UICategoryViewCell"];
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UICategoryViewCell"];
    }
    // Set the text on the cell with the description of the possession
    // that is at the nth index of possessions, where n = row this cell
    // will appear in on the tableview
    NSString *building = [self.categories objectAtIndex:[indexPath row]];
    [[cell textLabel] setText: building];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedBuilding = [self.categories objectAtIndex:[indexPath row]];
    /*
     DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
     detailViewController.building = selectedBuilding; // hand off the current product to the detail view controller
     
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
     [tableView deselectRowAtIndexPath:indexPath animated:NO];*/
    categoryDetailViewController.pickedCategory = selectedBuilding;
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
    if ( [[segue identifier] isEqualToString:@"categoryDetail"] ) {
        
       categoryDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller
        //categoryDetailViewController.pickedCategory = self.pickedCategory;    
    }

}


@end
