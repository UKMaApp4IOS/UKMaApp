//
//  ViewController.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 2/25/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController{
    GMSMapView *mapView_;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*CLLocationManager *locationManager;
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];*/
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
  
    
    //Sets cameras position to University of Kentucky.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.0333 longitude:-84.5000 zoom:14];
    
    //Creates map view for map and enables users location to be shown.
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;

    NSLog(@"User's location: %@", mapView_.myLocation);
    self.view = mapView_;//Sets current view to be mapView
    // Creates a marker in the center of the map.
    //Sample marker.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.03330,-84.5000 );
    marker.title = @"Lexington";
    marker.snippet = @"Kentucky";
    marker.map = mapView_;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    @end
