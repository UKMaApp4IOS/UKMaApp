//
//  Building.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/11/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
// Object class that is used to store building data as objects.
#import <Foundation/Foundation.h>

@interface Building : NSObject
@property (nonatomic) NSString * buildingName;
@property (nonatomic) NSString * buildingNickName;
@property (nonatomic) double  buildingLatitude;
@property (nonatomic) double  buildingLongitude;
@property (nonatomic) NSString * buildingUrl;
@property (nonatomic) NSString * buildingType;
@property (nonatomic) NSString * buildingHours;

- (id)initWithBuildingName:(NSString *) buildingName
          BuildingNickName:(NSString *) buildingNickName
          BuildingLatitude:(double ) buildingLatitude
          BuildingLongitude:(double ) buildingLongitude
          BuildingUrl:(NSString *) buildingUrl
          BuildingType:(NSString *) buildingType
          BuildingHours:(NSString *) buildingHours;
@end
