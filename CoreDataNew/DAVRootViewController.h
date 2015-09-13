//
//  DAVRootViewController.h
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAVTableViewController;
@class DAVCoreDataModel;

@interface DAVRootViewController : UIViewController

@property (strong, nonatomic) DAVTableViewController *tableViewController;
@property (strong, nonatomic) DAVCoreDataModel *model;

@property (weak, nonatomic) IBOutlet UILabel *lastUpdate;

- (IBAction)showListRss:(id)sender;
- (IBAction)updateRss:(id)sender;



@end
