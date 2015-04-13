//
//  DetailViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
 /*
 Abstract:
 The detail view controller navigated to from our main and results table.
 */
#import <UIKit/UIKit.h>
@class Building;
@interface DetailViewController : UIViewController
@property(nonatomic, strong) Building *building;
@end
