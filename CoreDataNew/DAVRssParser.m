//
//  DAVRssParser.m
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DAVRssParser.h"
#import "DAVRssItem.h"

@implementation DAVRssParser

@synthesize rssDict=_rssDict;
@synthesize countItems=_countItems;


-(id) init
{
    if ( self = [super init]) {
        _countItems = 0;
        _rssDict = [NSMutableDictionary dictionaryWithCapacity:20];
    }
    
    return self;
}

-(void) parseURL
{
    //NSLog(@"Begining parse");
    BOOL success;
    
    NSString *url = @"http://www.habrahabr.ru/rss/feed/9c4e5bba8b7b9daec2743211234a6348/";
    NSURL *rssURL = [NSURL URLWithString:url];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    
    success = [parser parse];
    
    //NSLog(@"%@", success);
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"begin of %@", elementName);
    
    if( [elementName isEqualToString:@"item"] ){
        _countItems += 1; 
        
        DAVRssItem *item = [[DAVRssItem alloc] init];
        item.title = @"title";
        
        [self.rssDict setObject:item 
                         forKey:[NSString stringWithFormat:@"%d", _countItems]];
    }
    
    if ([elementName isEqualToString:@"description"] && _countItems >= 1) {
        DAVRssItem *item = [self.rssDict objectForKey:[NSString stringWithFormat:@"%d",                                                      _countItems]];
        item.descriptions = @"description";
        [self.rssDict setObject:item 
                         forKey:[NSString stringWithFormat:@"%d", _countItems]];
        
    }
    
    if ([elementName isEqualToString:@"pubDate"] && _countItems >= 1) {
        DAVRssItem *item = [self.rssDict objectForKey:[NSString stringWithFormat:@"%d",                                                      _countItems]];
        item.pubDate = @"pubDate";
        [self.rssDict setObject:item 
                         forKey:[NSString stringWithFormat:@"%d", _countItems]];
        
    }
    
    if ([elementName isEqualToString:@"link"] && _countItems >= 1) {
        DAVRssItem *item = [self.rssDict objectForKey:[NSString stringWithFormat:@"%d",                                                      _countItems]];
        item.link = @"link";
        [self.rssDict setObject:item 
                         forKey:[NSString stringWithFormat:@"%d", _countItems]];
        
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"content - %@", string);
    
    NSString *stringWithoutWhitespace = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if( ![stringWithoutWhitespace isEqualToString:@""] && _countItems >= 1){
        DAVRssItem *item = [self.rssDict objectForKey:[NSString stringWithFormat:@"%d", 
                                                       _countItems]];
        
        if ( [item.title isEqualToString:@"title"] ) {
            item.title = stringWithoutWhitespace;
        } else if ( [item.descriptions isEqualToString:@"description"] ) {
            item.descriptions = stringWithoutWhitespace;
        } else if ( [item.link isEqualToString:@"link"] ) {
            item.link = stringWithoutWhitespace;            
        } else if ( [item.pubDate isEqualToString:@"pubDate"] ) {
            item.pubDate = stringWithoutWhitespace;            
        }
        //NSLog(@"count - %d, item - %@", self.countItems, item);
    }
    
}


-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    //NSLog(@"end of %@", elementName);
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error %i, Description: %@, Line: %i, Column: %i",[parseError code],[[parser parserError] localizedDescription],[parser lineNumber],[parser columnNumber]);
}


@end

