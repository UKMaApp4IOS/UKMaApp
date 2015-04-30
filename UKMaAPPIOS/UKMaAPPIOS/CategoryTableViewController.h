//
//  CategoryTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/15/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
Abstract:
File responsible; for displaying the categories that are listed in the file.
*/

#import <UIKit/UIKit.h>
#import "Building.h"
#import "BuildingStore.h"
#import "sqlite3.h"
@interface CategoryTableViewController : UITableViewController
{
    sqlite3 *db;

}
-(NSString*) filePath;
- (void) openDB;

@property (nonatomic) NSMutableArray * buildings;
@property (nonatomic) NSMutableArray * food;
@property (nonatomic) NSMutableArray * gyms;
@property (nonatomic) NSMutableArray * housing;
@property (nonatomic) NSMutableArray * libraries;
@property (nonatomic) NSMutableArray * categories;
@property (nonatomic) NSString * pickedCategory;
@end
