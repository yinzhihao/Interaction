//
//  ViewController.m
//  Interaction
//
//  Created by yinzhihao on 16/5/30.
//  Copyright © 2016年 yzh. All rights reserved. 来源于：http://blog.csdn.net/leyyang/article/details/47611593
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.0f green:20.0f blue:255.0f alpha:1.0f];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30.0f)];
    bar.backgroundColor = [UIColor clearColor];
    item_ = [[UINavigationItem alloc] initWithTitle:@""];
    
    [bar pushNavigationItem:item_ animated:YES];
    
    [self.view addSubview:bar];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0f, 60.0f, self.view.bounds.size.width-20, self.view.bounds.size.height - 80.0f)];
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    [self initWebView];
}

#pragma mark - 交互1：将HTML显示在APP上
- (void)initWebView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LoginJs/login" ofType:@"html"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
    
}

#pragma mark-delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    requestString = request.URL.absoluteString;
    NSLog(@"路径：%@",requestString);
    
    NSArray *headers = [requestString componentsSeparatedByString:@":"];
    
    if (headers.count > 1) {
        NSString *appAction = [[headers objectAtIndex:0] lowercaseString];
        NSString *functionName = [headers objectAtIndex:1];
        
        //交互2：通过点击HTML上的按钮调用APP的控件
        if ([appAction isEqualToString:@"jsinteraction"]) {
            if ([functionName isEqualToString:@"showAleart"] && [headers count] > 2) {
                NSString *message = [headers objectAtIndex:2];
                
                [self showAleart:message];
            }
            
            return NO;
        }
        //交互1：将HTML显示在APP上
        else if ([appAction isEqualToString:@"executescript"]) {
            if ([functionName isEqualToString:@"loginObj.setLoginInfo"]) {
                NSString *loginInfo = @"'{\"Username\":\"yzh\",\"Password\":\"zcsmart\"}'";
                NSString *execute = [NSString stringWithFormat:@"loginObj.setLoginInfo(%@)",loginInfo];
                
                [webView stringByEvaluatingJavaScriptFromString:execute];
            }
            return NO;
        }
    }
    
    return YES;
}

- (void)showAleart:(NSString *)message
{
//    UIAlertController *aleatC = [UIAlertController alertControllerWithTitle:@"Aleart" message:message preferredStyle:UIAlertControllerStyleAlert];
//    
//    [self presentViewController:aleatC animated:YES completion:nil];
    
    UIAlertView *aleartView = [[UIAlertView alloc] initWithTitle:@"Aleart" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aleartView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
