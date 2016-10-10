//
//  City.h
//  CityGame
//
//  Created by Baris.
//  Copyright (c) 2016 Baris. All rights reserved.
//

#import "UIKit/UIKit.h"


@interface City : NSObject

@property(strong, nonatomic)NSMutableString *cityName;
@property(strong, nonatomic)NSMutableString *cityID;

-(id)initWithCityName:(NSString *)cName andCityID:(NSString *)cID;

@end
