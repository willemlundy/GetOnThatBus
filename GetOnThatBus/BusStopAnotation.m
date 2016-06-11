//
//  BusStopAnotation.m
//  GetOnThatBus
//
//  Created by William Lundy on 10/13/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "BusStopAnotation.h"

@interface BusStopAnotation ()



@end

@implementation BusStopAnotation

- (instancetype)initWithDictionary:(NSDictionary *)busStopDictionary
{
    self = [super init];
    
    if (self)
    {
        self.coordinate = CLLocationCoordinate2DMake([busStopDictionary[@"latitude"] doubleValue] , [busStopDictionary[@"longitude"] doubleValue]);
        self.stopID = busStopDictionary[@"stop_id"];
        self.ctaStopName = busStopDictionary[@"cta_stop_name"];
        self.direction = busStopDictionary[@"direction"];
        self.routes = busStopDictionary[@"routes"];
        self.ward = busStopDictionary[@"ward"];
        
        if (busStopDictionary[@"inter_modal"])
        {
            self.interModal = busStopDictionary[@"inter_modal"];
        }

    }
    
    return self;
}

@end
