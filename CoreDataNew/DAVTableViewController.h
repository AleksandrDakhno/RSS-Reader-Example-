//
//  DAVTableViewController.h
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAVTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *titleList;
@property (strong, nonatomic) NSArray *linkList;
@property (strong, nonatomic) NSArray *pubDateList;

@end
