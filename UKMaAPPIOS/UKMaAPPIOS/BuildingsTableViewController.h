//
//  BuildingsTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/15/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "BuildingStore.h"
#import "sqlite3.h"

@interface BuildingsTableViewController : UITableViewController
{
    sqlite3 *db;
    
}
-(NSString*) filePath;
- (void) openDB;

@property (nonatomic) NSMutableArray * CategoryObjects;

@property (nonatomic) NSString * pickedCategory;

@end
