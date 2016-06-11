//
//  ListViewController.m
//  GetOnThatBus
//
//  Created by William Lundy on 10/13/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "BusStopAnotation.h"


@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    cell.textLabel.text = self.busStops[@"row"][indexPath.row][@"cta_stop_name"];
    
    cell.detailTextLabel.text = self.busStops[@"row"][indexPath.row][@"routes"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@", self.busStops[@"row"]);
    return [self.busStops[@"row"] count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *dvc = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    dvc.selectedAnnotation = [[BusStopAnotation alloc] initWithDictionary:self.busStops[@"row"][indexPath.row]];
    
    //NSLog(@"Passed Dictionary: %@", self.busStops[@"row"][indexPath.row]);
    
}

@end
