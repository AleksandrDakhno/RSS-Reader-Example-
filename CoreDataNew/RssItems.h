//
//  RssItems.h
//  CoreDataNew
//
//  Created by Anton Golub on 11/20/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RssItems : NSManagedObject

@property (nonatomic, retain) NSString * rssDescription;
@property (nonatomic, retain) NSString * rssLink;
@property (nonatomic, retain) NSString * rssPubDate;
@property (nonatomic, retain) NSString * rssTitle;

@end
