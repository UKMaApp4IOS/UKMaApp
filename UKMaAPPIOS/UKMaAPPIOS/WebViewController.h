//
//  WebViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/19/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//
/*
 Abstract:
 File responsible for controlling the webView that is segued with the building detail view controller. Note many of the the functions for the webview are done in the storyboard.
 */
#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic) NSString* url;
@property (weak, nonatomic) IBOutlet UIWebView *webView; //View for web.

@end
