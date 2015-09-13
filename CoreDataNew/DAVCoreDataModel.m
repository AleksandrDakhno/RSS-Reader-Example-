//
//  DAVCoreDataModel.m
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DAVCoreDataModel.h"
#import "DAVRssParser.h"
#import "DAVRssItem.h"

@implementation DAVCoreDataModel


@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

-(NSArray *) managedObjects
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"RssItems" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

-(NSArray *) managedObjectsWithPredicate:(NSPredicate *)pred
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"RssItems" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    return objects;
}

-(NSString *) lastDateUpdate{
    NSArray *objects = [self managedObjects];
    
    NSString *lastPubDate;
    
    if ([objects count] > 0) {
        NSManagedObject *lastObject = [objects objectAtIndex:[objects count] - 1];
        
        NSString *lastPubDateInBase = [lastObject valueForKey:@"rssPubDate"];    
        lastPubDate = [lastPubDateInBase substringWithRange:NSRangeFromString(@"5:17")];
    } else {
        lastPubDate = @"Empty base";
    }
        
    return lastPubDate;
}

-(BOOL) isDate:(NSString *)firstDate olderDate:(NSString *)secondDate
{
    NSArray *first = [firstDate componentsSeparatedByString:@" "];
    
    id firstDay = [first objectAtIndex:1];
    id firstMonth = [first objectAtIndex:2];
    id firstYear = [first objectAtIndex:3];
    
    id firstTime = [first objectAtIndex:4];
    NSArray *firstTimeArray = [firstTime componentsSeparatedByString:@":"];
    
    id firstHour = [firstTimeArray objectAtIndex:0];
    id firstMinute = [firstTimeArray objectAtIndex:1];
    id firstSeconds = [firstTimeArray objectAtIndex:2];
    
    NSArray *second = [secondDate componentsSeparatedByString:@" "];
    
    id secondDay = [second objectAtIndex:1];
    id secondMonth = [second objectAtIndex:2];
    id secondYear = [second objectAtIndex:3];
    
    id secondTime = [second objectAtIndex:4];
    NSArray *secondTimeArray = [secondTime componentsSeparatedByString:@":"];
    
    id secondHour = [secondTimeArray objectAtIndex:0];
    id secondMinute = [secondTimeArray objectAtIndex:1];
    id secondSeconds = [secondTimeArray objectAtIndex:2];
    
  
    if ([firstYear compare: secondYear] > 0) {
        return YES;
    } else if ([firstYear compare: secondYear] == 0) {
        if ([firstMonth compare: secondMonth] > 0) {
            return YES;
        } else if([firstMonth compare: secondMonth] == 0){
            if ([firstDay compare: secondDay] > 0) {
                return YES;
            } else if([firstDay compare: secondDay] == 0) {
                if ([firstHour compare: secondHour] > 0) {
                    return YES;
                } else if([firstHour compare: secondHour] == 0){
                    if ([firstMinute compare: secondMinute] > 0) {
                        return YES;
                    } else if([firstMinute compare: secondMinute] == 0){
                        if ([firstSeconds compare: secondSeconds] > 0) {
                            return YES;
                        } else if([firstSeconds compare: secondSeconds] == 0){
                            return NO;
                        } else {
                            return NO;
                        }
                    } else {
                        return NO;
                    }
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    

}

-(void) updateRecords
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    DAVRssParser *parser = [[DAVRssParser alloc] init];
    
    [parser parseURL];
    
    NSDictionary *rssDict = [parser rssDict];
    
    for (NSString *key in rssDict) {
        DAVRssItem *item = [rssDict objectForKey:key];

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"rssLink == %@", item.link];
        NSArray *objects = [self managedObjectsWithPredicate:pred];
        
        if (objects == nil) {
            NSLog(@"There was an arror!");
        }
        if ([objects count] == 0) {
            NSManagedObject *theRecord = [NSEntityDescription insertNewObjectForEntityForName:@"RssItems" inManagedObjectContext:context];
                
            [theRecord setValue:item.title forKey:@"rssTitle"];
            [theRecord setValue:item.descriptions forKey:@"rssDescription"];
            [theRecord setValue:item.pubDate forKey:@"rssPubDate"];
            [theRecord setValue:item.link forKey:@"rssLink"];
        } 
    }    
    [context save:&error];
}


-(NSArray *)titleList
{
    NSArray *objects = [self managedObjects];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    
    NSDate *dateNow = [[NSDate alloc] init];
    NSString *dateString = [NSString stringWithFormat:@"%@", dateNow];
    NSString *dayNow = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:20];
    
    for (NSManagedObject *oneObject in objects) {
        NSString *rssTitle = [oneObject valueForKey:@"rssTitle"];
        NSString *rssPubDate = [oneObject valueForKey:@"rssPubDate"];
        if ([rssTitle length] != 0) {
            NSString *day = [rssPubDate substringWithRange:NSMakeRange(5, 2)];
            if ([day isEqual:dayNow]) {
                [list addObject:rssTitle];
            }
        }           
    }
    
    return list;
}

-(NSArray *)descriptionList
{
    NSArray *objects = [self managedObjects];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    
    NSDate *dateNow = [[NSDate alloc] init];
    NSString *dateString = [NSString stringWithFormat:@"%@", dateNow];
    NSString *dayNow = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:20];
    
    for (NSManagedObject *oneObject in objects) {
        NSString *rssDesc = [oneObject valueForKey:@"rssDescription"];
        NSString *rssPubDate = [oneObject valueForKey:@"rssPubDate"];
        if ([rssDesc length] != 0) {
            NSString *day = [rssPubDate substringWithRange:NSMakeRange(5, 2)];
            if ([day isEqual:dayNow]) {
                [list addObject:rssDesc];
            }
        }           
    }
    
    return list;
}

-(NSArray *)pubDateList
{
    NSArray *objects = [self managedObjects];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    
    NSDate *dateNow = [[NSDate alloc] init];
    NSString *dateString = [NSString stringWithFormat:@"%@", dateNow];
    NSString *dayNow = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:20];
    
    for (NSManagedObject *oneObject in objects) {
        NSString *rssPubDate = [oneObject valueForKey:@"rssPubDate"];
        if ([rssPubDate length] != 0) {
            NSString *day = [rssPubDate substringWithRange:NSMakeRange(5, 2)];
            if ([day isEqual:dayNow]) {
                [list addObject:rssPubDate];
            }
        }           
    }
    
    return list;
}

-(NSArray *)linkList
{
    NSArray *objects = [self managedObjects];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    
    NSDate *dateNow = [[NSDate alloc] init];
    NSString *dateString = [NSString stringWithFormat:@"%@", dateNow];
    NSString *dayNow = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:20];
    
    for (NSManagedObject *oneObject in objects) {
        NSString *rssLink = [oneObject valueForKey:@"rssLink"];
        NSString *rssPubDate = [oneObject valueForKey:@"rssPubDate"];
        if ([rssLink length] != 0) {
            NSString *day = [rssPubDate substringWithRange:NSMakeRange(5, 2)];
            if ([day isEqual:dayNow]) {
                [list addObject:rssLink];
            }
        }           
    }
    
    return list;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataNew" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataNew.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
