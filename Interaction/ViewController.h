//
//  ViewController.h
//  Interaction
//
//  Created by yinzhihao on 16/5/30.
//  Copyright © 2016年 yzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    UINavigationItem *item_;
}
@property (nonatomic, strong) UIWebView *webView;
@end

