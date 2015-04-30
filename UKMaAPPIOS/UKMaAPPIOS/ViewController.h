//
//  ViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 2/25/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract:
 File responsible for displaying the map. It is also the GMSMapViewDelegate. Note this is the first view controller of the app. This is where you will implement 90% of the functions for google maps.
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "building.h"
#import <GoogleMaps/GoogleMaps.h>
#import "BuildingStore.h"
#import "sqlite3.h"

@interface ViewController : UIViewController<GMSMapViewDelegate>
{
    sqlite3 *db;
    
}
-(NSString*) filePath;
- (void) openDB;

@property (nonatomic) NSMutableArray * buildingObjects; //Array of building objects


@property (nonatomic) BOOL isSearch; // Has there been a search
@property (nonatomic) NSMutableArray *searchedBuildingResults; //The searched building object

@end