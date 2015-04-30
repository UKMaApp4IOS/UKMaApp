//
//  AppDelegate.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 2/25/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
//Abstract:: This is the files that get called when app starts. This class is also the Location manager delagate.
#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //API key used for map services from Google.
    [GMSServices provideAPIKey:@"AIzaSyDtjb0wnn0crUHBjDeBQlGj0dJ2ZTioFvI"];
    // Override point for customization after application launch.
    //Initialize a location manager and set various options to controll accuracy.
    self.locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    // Check if system version for current device is greater than 8.0, if so request users location data use.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    return YES;
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}
//Called when location changed.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    NSLog(@"%@", currentLocation);
    //The following code reverse geocodes location and prints location to terminal.
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Area: %@", placemark.administrativeArea);
            NSLog(@"City: %@", placemark.locality);
            NSLog(@"Code: %@", placemark.postalCode);
            NSLog(@"Road: %@", placemark.thoroughfare);
            NSLog(@"Number: %@", placemark.subThoroughfare);
            
            // Stop Location Manager
            [self.locationManager stopUpdatingLocation];
            
        } else {
            NSLog(@"%@", error.debugDescription);
            [self.locationManager stopUpdatingLocation];
            
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
