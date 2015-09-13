//
//  DAVWebViewController.m
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DAVWebViewController.h"

@implementation DAVWebViewController

@synthesize webView;
@synthesize urlString=_urlString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.title = @"Web page";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:_urlString]]];
    self.webView.scalesPageToFit = YES;
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.urlString = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
