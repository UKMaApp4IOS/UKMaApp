//
//  BaseTableViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Building;
extern NSString *const kCellIdentifier;
@interface BaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forBuilding:(Building *)product;
@end
