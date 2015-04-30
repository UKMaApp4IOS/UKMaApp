//
//  BuildingDetailViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/19/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract:
 File responsible for displaying the buildings object in the a view controlled by this controller. Displayes name, category, hours if it has them, and a way to go to webView by clicking button. Also a button to go to the map.
 */
#import <UIKit/UIKit.h>
#import "Building.h"
@interface BuildingDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
- (IBAction)goToMap:(id)sender;
@property (nonatomic) Building * pickedBuilding;
- (IBAction)goToWeb:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *goToWebButton;

@end
