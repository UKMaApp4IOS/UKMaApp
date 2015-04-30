//
//  BaseTableViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract:
 Base or common view controller to share a common UITableViewCell prototype between subclasses.
 Class file for the base table view controller that Main Table View Controller and Results Table view controller depend on. Used for implementing the search and search bar functionality.
 
 */

#import "BaseTableViewController.h"
#import "Building.h"

@interface BaseTableViewController ()

@end
NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"TableCell";
@implementation BaseTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forBuilding:(Building *)building {
    //Change the cells text and detail text labels.
    cell.textLabel.text = building.buildingName;


    cell.detailTextLabel.text = @"";
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
