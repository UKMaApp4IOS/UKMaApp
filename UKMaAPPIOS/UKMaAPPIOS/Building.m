//
//  Building.m
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/11/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import "Building.h"

@implementation Building
- (id)init {
    return [self initWithBuildingName:@"Building" BuildingNickName:@"Building"  BuildingLatitude:1.223  BuildingLongitude:1.233  BuildingUrl:@"Building"  BuildingType:@"Building"  BuildingHours:@"Building"];
}
- (id)initWithBuildingName:(NSString *) buildingName
          BuildingNickName:(NSString *) buildingNickName
          BuildingLatitude:(double) buildingLatitude
         BuildingLongitude:(double) buildingLongitude
               BuildingUrl:(NSString *) buildingUrl
              BuildingType:(NSString *) buildingType
             BuildingHours:(NSString *) buildingHours
{
    // Call the superclass's designated initializer
    self = [super init];
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        [self setBuildingName:buildingName];
        [self setBuildingNickName:buildingNickName];
        [self setBuildingLatitude:buildingLatitude];
        [self setBuildingLongitude:buildingLongitude];
        [self setBuildingUrl:buildingUrl];
        [self setBuildingType:buildingType];
        [self setBuildingHours:buildingHours];
    }
    // Return the address of the newly initialized object
    return self;
}
@end
