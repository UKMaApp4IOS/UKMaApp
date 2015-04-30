//
//  MainTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract:
 Header file to implement the MainTableView for the search function. This controller is the first table view the users see after clicking on the search button in the app. It loads, stores, and displayes the building information into a table view. This controller is also resposible for UISearchController protocols, and is the delegate and datasource, updatesource for the searched data.
 
 */
#import <UIKit/UIKit.h>

#import "Building.h"
#import "BuildingStore.h"
#import "sqlite3.h"
#import "BaseTableViewController.h"
@interface MainTableViewController : BaseTableViewController
{
    sqlite3 *db; //Database
}
-(NSString*) filePath;//Filepath to database
- (void) openDB;//Function to openDB

@end
