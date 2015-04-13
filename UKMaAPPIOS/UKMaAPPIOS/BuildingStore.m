//
//  BuildingStore.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/11/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "BuildingStore.h"
#import "Building.h"
static BuildingStore *defaultStore = nil;
@implementation BuildingStore
+ (BuildingStore *)defaultStore
{
    if (!defaultStore) {
        // Create the singleton
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}
// Prevent creation of additional instances
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}
- (id)init {
    // If we already have an instance of BuildingStore...
    if (defaultStore) {
        // Return the old one
        return defaultStore;
    }
    self = [super init];
    if (self) {
        allBuildings = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSArray *)allBuildings
{
    return allBuildings;
}
- (Building *)createBuildingName:(NSString *) buildingName
                 BuildingNickName:(NSString *) buildingNickName
                 BuildingLatitude:(double ) buildingLatitude
                BuildingLongitude:(double ) buildingLongitude
                      BuildingUrl:(NSString *) buildingUrl
                     BuildingType:(NSString *) buildingType
                    BuildingHours:(NSString *) buildingHours
{
    //Create building object
    Building *b = [[Building alloc] initWithBuildingName:buildingName BuildingNickName:buildingNickName BuildingLatitude:buildingLatitude BuildingLongitude:buildingLongitude BuildingUrl:buildingUrl BuildingType:buildingType BuildingHours:buildingHours];
    //Add buidling object to array.
    [allBuildings addObject:b];
    return b;
}
@end
