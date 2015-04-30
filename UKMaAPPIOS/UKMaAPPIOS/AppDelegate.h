//
//  AppDelegate.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 2/25/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//


// Abstract: THis is the class files that get called when App starts.
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;// Handles devices location information.
@end

