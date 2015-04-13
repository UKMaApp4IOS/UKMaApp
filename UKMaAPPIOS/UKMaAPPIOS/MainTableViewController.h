//
//  MainTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Building.h"
#import "BuildingStore.h"
#import "sqlite3.h"
#import "BaseTableViewController.h"
@interface MainTableViewController : BaseTableViewController
{
    sqlite3 *db;
}
-(NSString*) filePath;
- (void) openDB;
@end
