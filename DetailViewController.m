//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by William Lundy on 10/13/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "DetailViewController.h"
#import "BusStopAnotation.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stopName;
@property (weak, nonatomic) IBOutlet UILabel *stopAddress;
@property (weak, nonatomic) IBOutlet UILabel *routes;
@property (weak, nonatomic) IBOutlet UILabel *transfers;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stopName.text = self.selectedAnnotation.ctaStopName;
    self.stopAddress.text = self.selectedAnnotation.stopID;
    self.routes.text = self.selectedAnnotation.routes;
    self.transfers.text = self.selectedAnnotation.interModal;
    NSLog(@"%@", self.selectedAnnotation);
    self.title = self.selectedAnnotation.ctaStopName;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
