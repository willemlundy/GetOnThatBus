//
//  ViewController.m
//  GetOnThatBus
//
//  Created by William Lundy on 10/13/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "ViewController.h"
#import "BusStopAnotation.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "ListViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSDictionary *busStops;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        double chicagoLatitude = 41.8369;
        double chicagoLongitude = -87.6847;
    
        MKPointAnnotation *initialLocation =[MKPointAnnotation new];
        initialLocation.coordinate = CLLocationCoordinate2DMake(chicagoLatitude, chicagoLongitude);
    
        [self.mapView setRegion:MKCoordinateRegionMake(initialLocation.coordinate, MKCoordinateSpanMake(0.5, 0.5)) animated:NO];
    
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mmios8week/bus.json"];
    //NSError *error;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.busStops = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView reloadInputViews];
            for (NSDictionary *busStop in self.busStops[@"row"])
            {
                
                BusStopAnotation *busStopAnnotation = [[BusStopAnotation alloc] initWithDictionary:busStop];
                
                busStopAnnotation.title = busStop[@"cta_stop_name"];
                
                busStopAnnotation.subtitle = busStop[@"routes"];
                
                [self.mapView addAnnotation:busStopAnnotation];
                
                ListViewController *tempList = [[self.tabBarController viewControllers] objectAtIndex:1];
                
                tempList.busStops = self.busStops;
              
            }
        });
        
        
        NSLog(@"Out of for loop");
        [self.mapView reloadInputViews];
        //[self zoomToFit:self.mapView];
    }];
    
    [task resume];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

    BusStopAnotation *tempAnnotation = annotation;
    
    // Build a UIView for the Icon
    UIImageView *busIconView = [[UIImageView alloc] init];
    
    
    
    if ([tempAnnotation.interModal isEqualToString:@"Metra"])
    {
        NSLog(@"Metra");
        pin.image = [UIImage imageNamed:@"BlueBus"];
        busIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MetroLogo"]];
        
    } else if ([tempAnnotation.interModal isEqualToString:@"Pace"]) {
        pin.image = [UIImage imageNamed:@"BlueBus"];
        busIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pace"]];
        
    } else {
        pin.image = [UIImage imageNamed:@"bus-orange-md"];
        busIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CTA"]];
    }
    
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [busIconView setFrame:CGRectMake(0, 0, 45, 45)];
    pin.leftCalloutAccessoryView = busIconView;
    
    return pin;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // [mapView setRegion:MKCoordinateRegionMake(view.annotation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:NO];
    [self performSegueWithIdentifier:@"DetailSegue" sender:control];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"%@", sender);
    
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
        BusStopAnotation *selectedAnnotation = [self.mapView selectedAnnotations].firstObject;
        
        DetailViewController *dvc = segue.destinationViewController;
        
        dvc.selectedAnnotation = selectedAnnotation;
    }
    else if ([segue.identifier isEqualToString:@"ListSegue"])
    {
        ListViewController *lvc = segue.destinationViewController;
        
        lvc.busStops = self.busStops;
        NSLog(@"Prepare for Segue: %@", self.busStops);
    }
    
}

@end
