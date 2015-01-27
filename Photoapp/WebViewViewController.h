//
//  WebViewViewController.h
//  Photoapp
//
//  Created by maxcon4 on 04/03/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView_new;
    UIActivityIndicatorView *spinner;
}
@end
