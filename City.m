//
//  City.m
//  CityGame
//
//  Created by Baris.
//  Copyright (c) 2016 Baris. All rights reserved.
//

#import "City.h"

@implementation City

-(id)initWithCityName:(NSMutableString *)cName andCityID:(NSMutableString *)cID{
    self = [super init];
    if(self){
        _cityName = cName;
        _cityID = cID;
    }
    return self;
}




@end
