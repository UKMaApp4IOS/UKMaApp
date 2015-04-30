//
//  BaseTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract: Header file for the base table view controller that Main Table View Controller and Results Table view controller depend on. Used for implementing the search and search bar functionality.
 
 
 
*/
#import <UIKit/UIKit.h>
@class Building;
extern NSString *const kCellIdentifier; // Cell Identifier
@interface BaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forBuilding:(Building *)product;//Function to configure a new cell for the Table view controllers.
@end
