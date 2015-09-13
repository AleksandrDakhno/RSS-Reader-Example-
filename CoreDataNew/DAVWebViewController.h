//
//  DAVWebViewController.h
//  CoreDataNew
//
//  Created by Aleksandr Dakhno on 7/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAVWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *urlString;

@end
