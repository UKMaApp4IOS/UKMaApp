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
@interface ViewController () <UISearchBarDelegate, UISearchResultsUpdating, GMSMapViewDelegate >
@property (strong, nonatomic) NSArray *filteredList;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) Building *TappedBuilding;
@property (nonatomic) bool didTapBuilding;
@end

@implementation ViewController{
    GMSMapView *mapView_;
    GMSMarker *searchedMarker;
    GMSMarker *tappedMarker;
}

-(NSString *) filePath {
    // NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //return [[paths objectAtIndex: 0] stringByAppendingPathComponent:@"Warframe.sqlite"];
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSLog(@"%@", mainBundle);
    NSString * myFile = [mainBundle pathForResource: @"Buildings" ofType: @"sqlite"];
    NSLog(@"%@", myFile);
    
    return myFile;
    
}

-(void) openDB{
    if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open");
    }
    else{
        NSLog(@"Database opened");
    }
}

- (void)viewDidLoad {
    NSArray * BuildingsArray = [[BuildingStore defaultStore] allBuildings];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT Name,NickName, Latitude, Longitude, Url, Type, Hours FROM Buildings"];
    //sql = [sql stringByAppendingString:self.pickedCategory];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) ==SQLITE_OK)
    {
        int i = 0;
        while(sqlite3_step(statement)==SQLITE_ROW){
            NSString *field2Str;
            NSString *field5Str;
            NSString *field6Str;
            NSString *field7Str;
            char *field1 = (char *) sqlite3_column_text(statement,0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            char *field2 = (char *) sqlite3_column_text(statement,1);
            if(field2 == NULL)
            {
                field2Str = @"NULL";
            }
            else{
                field2Str = [[NSString alloc] initWithUTF8String:field2];
            }
            
            double field3 = (double) sqlite3_column_double(statement,2);
            //            double field3Str = [[double alloc] initWithUTF8String:field3];
            double field4 = (double) sqlite3_column_double(statement,3);
            //            double *field4Str = [[NSString alloc] initWithUTF8String:field4];
            char *field5 = (char *) sqlite3_column_text(statement,4);
            if(field5 == NULL)
            {
                field5Str = @"NULL";
            }
            else{
                field5Str = [[NSString alloc] initWithUTF8String:field5];
            }
            char *field6 = (char *) sqlite3_column_text(statement,5);
            if(field6 == NULL)
            {
                field6Str = @"NULL";
            }
            else{
                field6Str = [[NSString alloc] initWithUTF8String:field6];
            }
            char *field7 = (char *) sqlite3_column_text(statement,6);
            if(field7 == NULL)
            {
                field7Str = @"NULL";
            }
            else{
                field7Str = [[NSString alloc] initWithUTF8String:field7];
            }
            
            
            
            
            
            [[BuildingStore defaultStore] createBuildingName:(NSString *) field1Str
                                            BuildingNickName:(NSString *) field2Str
                                            BuildingLatitude:(double ) field3
                                           BuildingLongitude:(double ) field4
                                                 BuildingUrl:(NSString *) field5Str
                                                BuildingType:(NSString *) field6Str
                                               BuildingHours:(NSString *) field7Str];
            NSLog(@"Building Name : %@  BuildingNickName: %@, BuildingLat: %f, BuildingLong: %f, building URL: %@, buildingType: %@, BuildingHours: %@ ", field1Str, field2Str, field3, field4, field5Str, field6Str, field7Str);
            //NSLog(@"Building Name :   Rarity: ");
    
            
        }
    }
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
  
    
  
    /*
    //Sets cameras position to University of Kentucky.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.0333 longitude:-84.5000 zoom:14];
    //CGRect screenRect = [[UIScreen mainScreen]];
    ////mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //Creates map view for map and enables users location to be shown.
    //mapView_ = [GMSMapView mapWithFrame:[CGRectMake(0, self.navigationController.navigationBar.frame.size.height, screenRect.size.width, screenRect.size.height - self.navigationController.navigationBar.frame.size.height)] camera:camera];
    
    //mapView_  = [GMSMapView mapWithFrame: [CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120) ] camera:camera];

    CGRect mapRect = CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-120);
    mapView_ = [GMSMapView mapWithFrame: mapRect camera: camera];
    
    mapView_.myLocationEnabled = YES;
    [mapView_ setMinZoom:13 maxZoom:mapView_.maxZoom];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    NSLog(@"User's location: %@", mapView_.myLocation);
    self.view = mapView_;//Sets current view to be mapView
    // Creates a marker in the center of the map.
    //Sample marker.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.03330,-84.5000 );
    marker.title = @"Lexington";
    marker.snippet = @"Kentucky";
    
    marker.map = mapView_;
    
    searchedMarker = [[GMSMarker alloc] init];
    [mapView_ setSelectedMarker:marker];
    */
    
    
    //Sets cameras position to University of Kentucky.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.0333 longitude:-84.5000 zoom:14];
    //CGRect screenRect = [[UIScreen mainScreen]];
    ////mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //Creates map view for map and enables users location to be shown.
    //mapView_ = [GMSMapView mapWithFrame:[CGRectMake(0, self.navigationController.navigationBar.frame.size.height, screenRect.size.width, screenRect.size.height - self.navigationController.navigationBar.frame.size.height)] camera:camera];
    
    //mapView_  = [GMSMapView mapWithFrame: [CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120) ] camera:camera];
    
    CGRect mapRect = CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-120);
    mapView_ = [GMSMapView mapWithFrame: mapRect camera: camera];
    [self.view addSubview:mapView_];
    //self.view.addSubview(mapView_);
    mapView_.mapType = kGMSTypeNormal;

    mapView_.delegate = self;
    
    
    
    
    
    
    mapView_.myLocationEnabled = YES;
    [mapView_ setMinZoom:13 maxZoom:mapView_.maxZoom];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    NSLog(@"User's location: %@", mapView_.myLocation);
    self.view = mapView_;//Sets current view to be mapView
    // Creates a marker in the center of the map.
    //Sample marker.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.03330,-84.5000 );
    marker.title = @"Lexington";
    marker.snippet = @"Kentucky";
    
    marker.map = mapView_;
    
    searchedMarker = [[GMSMarker alloc] init];
    tappedMarker = [[GMSMarker alloc] init];
    [mapView_ setSelectedMarker:marker];
    self.navigationItem.title = @"UKMA-APP";
}
- (void) viewWillAppear:(BOOL)animated{
    if(self.isSearch)
        {
            //searchedMarker = [[GMSMarker alloc] init];
            //camera = [GMSCameraPosition cameraWithLatitude:self.searchedBuilding.buildingLatitude longitude:self.searchedBuilding.buildingLongitude zoom:14];
            //Creates map view for map and enables users location to be shown.
            //mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
            //mapView_.myLocationEnabled = YES;
            [mapView_ animateToLocation:CLLocationCoordinate2DMake(self.searchedBuilding.buildingLatitude, self.searchedBuilding.buildingLongitude)];
            searchedMarker.position = CLLocationCoordinate2DMake(self.searchedBuilding.buildingLatitude,self.searchedBuilding.buildingLongitude );
            searchedMarker.title = self.searchedBuilding.buildingName;
            NSString * snippitString = @"";
            NSString *string1 = nil;
            NSString *string2 = nil;
            if([self.searchedBuilding.buildingType isEqual: @"NULL"]){
                string1 = @"";
                
            }
            else
            {
                string1 = [NSString stringWithFormat:@"Type: %@", self.searchedBuilding.buildingType];
            }
            if([self.searchedBuilding.buildingHours isEqual: @"NULL"]){
                string2 = @"";
                
            }
            else
            {
                string2 = [NSString stringWithFormat:@"Hours: %@", self.searchedBuilding.buildingHours];
            }
            snippitString = [NSString stringWithFormat:@"%@ \r %@", string1, string2];
            
            
            searchedMarker.snippet = snippitString;
            searchedMarker.appearAnimation = kGMSMarkerAnimationPop;
            searchedMarker.map = mapView_;
            [mapView_ setSelectedMarker:searchedMarker];
            [mapView_ animateToZoom:18];
            
        }

    
}

- (void) viewWillDisappear:(BOOL)animated{
    mapView_.selectedMarker = nil;
}
- (void) mapView: (GMSMapView*) mapVIew didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    NSLog(@"cat");
    Building * building = nil;
    double area = 0.0003;
    NSArray *buildings = [[BuildingStore defaultStore] allBuildings];
    double buildingLatitude;
    double buildingLongitude;
    self.didTapBuilding = false;
    for (int i=0; i< buildings.count; i++  ) {
        buildingLatitude = [buildings[i] buildingLatitude];
        buildingLongitude = [buildings[i] buildingLongitude];
        if((coordinate.latitude < buildingLatitude + area )&& (coordinate.latitude > buildingLatitude - area) && (coordinate.longitude < buildingLongitude + area )&& (coordinate.longitude > buildingLongitude - area)
           )
        {
            self.TappedBuilding = buildings[i];
            area = area - 0.0002;
            NSLog(@"hahayes");
            self.didTapBuilding = TRUE;
            
            
        }
        
    }
    if(self.didTapBuilding){
        //[mapView_ clear];
        [mapView_ animateToLocation:CLLocationCoordinate2DMake(self.TappedBuilding.buildingLatitude, self.TappedBuilding.buildingLongitude)];
        
        tappedMarker.position = CLLocationCoordinate2DMake(self.TappedBuilding.buildingLatitude,self.TappedBuilding.buildingLongitude );
        tappedMarker.title = self.TappedBuilding.buildingName;
        NSString * snippitString = @"";
        NSString *string1 = nil;
         NSString *string2 = nil;
         if([self.TappedBuilding.buildingType isEqual: @"NULL"]){
         string1 = @"";
         
         }
         else
         {
         string1 = [NSString stringWithFormat:@"Type: %@", self.TappedBuilding.buildingType];
         }
         if([self.TappedBuilding.buildingHours isEqual: @"NULL"]){
         string2 = @"";
         
         }
         else
         {
         string2 = [NSString stringWithFormat:@"Hours: %@", self.TappedBuilding.buildingHours];
         }
         snippitString = [NSString stringWithFormat:@"%@ \r %@", string1, string2];
         
        
        tappedMarker.snippet = snippitString;
        //tappedMarker.appearAnimation = kGMSMarkerAnimationPop;
        tappedMarker.map = mapView_;
        [mapView_ setSelectedMarker:tappedMarker];
        //[mapView_ ];
        //searchedMarker = nil;
        self.didTapBuilding = false;
    }else{
        NSLog(@"dog");
    }
    
    
    NSLog(@"%f, %f", coordinate.latitude, coordinate.longitude);
/*    [self.view setNeedsDisplay];
    [mapView_ setNeedsDisplay];
    if(self.didTapBuilding)
    {
        //[self viewDidLoad];
        [self viewWillAppear:TRUE];
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    @end
/*
 [mapView_ clear]; //Remove all markers/overlays
 marker.map = nil; //disable marker to use later
 marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];// change color
 london.icon = [UIImage imageNamed:@"house"];//change marker icon
 marker.flat = YES;
 //Add poly lines
 
 
 
 
 
 */
