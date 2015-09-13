//
//  DAVRssItem.h
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAVRssItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSString *pubDate;
@property (strong, nonatomic) NSString *link;

@end
