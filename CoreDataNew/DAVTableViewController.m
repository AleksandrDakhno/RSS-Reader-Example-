//
//  DAVTableViewController.m
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DAVTableViewController.h"
#import "DAVRssParser.h"
#import "DAVCoreDataModel.h"
#import "DAVWebViewController.h"


@implementation DAVTableViewController

@synthesize titleList=_titleList;
@synthesize linkList=_linkList;
@synthesize pubDateList=_pubDateList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.title = @"List RSS";
    
    DAVCoreDataModel *model = [[DAVCoreDataModel alloc] init];
    
    NSLog(@"Show lists");
    
    _titleList = [model titleList];
    _linkList = [model linkList];
    _pubDateList = [model pubDateList];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.titleList = nil;
    self.linkList = nil;
    self.pubDateList = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.titleList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
   
    cell.textLabel.text = [_titleList objectAtIndex:row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.textLabel.numberOfLines = 0;
    
    
    cell.detailTextLabel.text = [_pubDateList objectAtIndex:row];
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:11];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

    DAVWebViewController *webController =[[DAVWebViewController alloc] init];
    
    NSUInteger row = [indexPath row];
    NSString *urlString = [self.linkList objectAtIndex:row];
    webController.urlString = urlString;
    //NSLog(@"%@", urlString);
    [self.navigationController pushViewController:webController animated:YES];
}

@end