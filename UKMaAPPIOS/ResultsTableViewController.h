//
//  ResultsTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
/*
 Abstract:
 Header file to implement the search results of the mainTableView for the search function. This controller is the second table view the users see after clicking on the search button in the app. It loads, stores, and displayes the building information into a table view.
 
 */
@interface ResultsTableViewController : BaseTableViewController
@property (nonatomic, strong) NSArray *filteredBuildings;//Array to stored filtered building objects.
@end
