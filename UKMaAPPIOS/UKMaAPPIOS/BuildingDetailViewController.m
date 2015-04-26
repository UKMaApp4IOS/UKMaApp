//
//  BuildingDetailViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/19/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "BuildingDetailViewController.h"
#import "WebViewController.h"
#import "ViewController.h"

@interface BuildingDetailViewController ()

@end

@implementation BuildingDetailViewController
WebViewController *webViewController = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([self.pickedBuilding.buildingName  isEqual: @"NULL"]){
        self.nameLabel.text = @"";
    }
    else
    {
        self.nameLabel.text = self.pickedBuilding.buildingName;
        
    }
    if([self.pickedBuilding.buildingUrl isEqual: @"NULL"]){
        self.goToWebButton.enabled = false;
        [self.goToWebButton setTitle:@"" forState:UIControlStateNormal];
    }
    if([self.pickedBuilding.buildingHours isEqual: @"NULL"]){
        self.hoursLabel.text = @"";
        
    }
    else
    {
        self.hoursLabel.text = self.pickedBuilding.buildingHours;
    }
    NSLog(@"size is %lu", (unsigned long)self.navigationController.viewControllers.count);
    
    
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
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ( [[segue identifier] isEqualToString:@"webView"] ) {
        
        webViewController = [segue destinationViewController];
        webViewController.url = self.pickedBuilding.buildingUrl;
        
        // In order to manipulate the destination view controller
        //categoryDetailViewController.pickedCategory = self.pickedCategory;
    }
    
}
- (IBAction)goToMap:(id)sender {
    ViewController * rootViewControllerPointer =  (ViewController*) (self.navigationController.viewControllers[0]);
    rootViewControllerPointer.isSearch = true;
    rootViewControllerPointer.searchedBuilding = self.pickedBuilding;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)goToWeb:(id)sender {
}
@end
