//
//  BuildingDetailViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/19/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
@interface BuildingDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *uRLLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
- (IBAction)goToMap:(id)sender;
@property (nonatomic) Building * pickedBuilding;
- (IBAction)goToWeb:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *goToWebButton;

@end
