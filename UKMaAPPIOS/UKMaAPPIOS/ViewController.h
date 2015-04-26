//
//  ViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 2/25/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "building.h"
#import <GoogleMaps/GoogleMaps.h>
#import "BuildingStore.h"
#import "sqlite3.h"
//#import <CLLocationManager.h>
@interface ViewController : UIViewController<GMSMapViewDelegate>
{
    sqlite3 *db;
    
}
-(NSString*) filePath;
- (void) openDB;

@property (nonatomic) NSMutableArray * buildingObjects;


@property (nonatomic) BOOL isSearch;
@property (nonatomic) Building *searchedBuilding;
@end