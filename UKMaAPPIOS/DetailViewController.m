//
//  DetailViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/13/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*Abstract:
 The detail view controller navigated to from our main and results table.
 */


#import "DetailViewController.h"
#import "Building.h"
@interface DetailViewController ()
@property(nonatomic, weak) IBOutlet UILabel *buildingName;

@end
#pragma mark -
@implementation DetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.building.buildingName;
    
    self.buildingName.text = self.building.buildingName ;
}

#pragma mark - UIStateRestoration

NSString *const ViewControllerBuildingKey = @"ViewControllerBuildingKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the product
    [coder encodeObject:self.building forKey:ViewControllerBuildingKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the product
    self.building = [coder decodeObjectForKey:ViewControllerBuildingKey];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
