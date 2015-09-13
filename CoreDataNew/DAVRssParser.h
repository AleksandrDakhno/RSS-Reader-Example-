//
//  DAVRssParser.h
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAVRssParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableDictionary *rssDict;
@property (nonatomic) int countItems;

-(void) parseURL;

//-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
//-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
//-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
//-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@end
