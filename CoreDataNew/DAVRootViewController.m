//
//  DAVRootViewController.m
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DAVRootViewController.h"
#import "DAVTableViewController.h"
#import "DAVCoreDataModel.h"

@implementation DAVRootViewController

@synthesize lastUpdate = _lastUpdate;
@synthesize model=_model;


@synthesize tableViewController=_tableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _model = [[DAVCoreDataModel alloc] init];        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Main page";
    
    _lastUpdate.text = [_model lastDateUpdate];
}

- (void)viewDidUnload
{
    [self setLastUpdate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _tableViewController=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showListRss:(id)sender
{
    
    _tableViewController = [[DAVTableViewController alloc] initWithNibName:@"DAVTableViewController" bundle:nil]; 
    
    [self.navigationController pushViewController:_tableViewController animated:YES];

}

- (IBAction)updateRss:(id)sender
{
    [_model updateRecords];
    _lastUpdate.text = [_model lastDateUpdate];
}

@end
