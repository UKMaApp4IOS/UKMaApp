//
//  exampleViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/26/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "BuildingStore.h"
#import "sqlite3.h"
#import "BaseTableViewController.h"
@interface exampleViewController : UIViewController
{
    sqlite3 *db;
}
@property (weak, nonatomic) IBOutlet UISearchBar *mapSearchBar;
-(NSString*) filePath;
- (void) openDB;

@end
