//
//  ViewController.m
//  UKMa-app_1
//
//  Created by Christine Mattingly on 3/2/15.
//  Copyright (c) 2015 Christine Mattingly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.0333
                                                            longitude:-84.5000
                                                                 zoom:3];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.0333, -84.5000);
    marker.title = @"University of Kentucky";
    marker.snippet = @"Lexington, KY";
    marker.map = mapView_;
    
    // My location
    NSLog(@"User's location: %@", mapView_.myLocation);
    
    // My location button
    mapView_.settings.myLocationButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
