//
//  BusStopAnotation.h
//  GetOnThatBus
//
//  Created by William Lundy on 10/13/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface BusStopAnotation : MKPointAnnotation

- (instancetype)initWithDictionary:(NSDictionary *)busStopDictionary;

//"stop_id": "69",
@property NSString *stopID;

//"cta_stop_name": "Jackson & Financial",
@property NSString *ctaStopName;

//"direction": "EB",
@property NSString *direction;

//"routes": "1,7,X28,126,129,130,132,151",
@property NSString *routes;

//"ward": "2",
@property NSString *ward;

//"inter_modal": "Metra",
@property NSString *interModal;

@end
