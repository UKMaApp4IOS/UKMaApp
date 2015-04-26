//
//  BuildingStore.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/11/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
// Class file that creates one instance BuildingStore of NSObject to store building objects in an array.
 #import <Foundation/Foundation.h>
@class Building;
@interface BuildingStore : NSObject
{
    NSMutableArray * allBuildings;
}
+(BuildingStore *) defaultStore;
-(NSArray *) allBuildings;
-(Building *) createBuildingName:(NSString *) buildingName
              BuildingNickName:(NSString *) buildingNickName
              BuildingLatitude:(double ) buildingLatitude
             BuildingLongitude:(double ) buildingLongitude
                   BuildingUrl:(NSString *) buildingUrl
                  BuildingType:(NSString *) buildingType
                 BuildingHours:(NSString *) buildingHours;
-(void) clearStore;
@end
