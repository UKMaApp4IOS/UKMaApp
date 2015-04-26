//
//  WebViewController.h
//  UKMaAPPIOS
//
//  Created by Patrick Good on 4/19/15.
//  Copyright (c) 2015 Patrick Good. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic) NSString* url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
