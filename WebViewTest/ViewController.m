//
//  ViewController.m
//  WebViewTest
//
//  Created by rimi on 2016/12/29.
//  Copyright © 2016年 iOS-ZX. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>

/** UIWebView **/
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *httpUrl=[NSURL fileURLWithPath:path];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:httpUrl];
    [self.webView loadRequest:httpRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context=[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *js = @"alert(\"在OC中执行JS代码\")";
//    [context evaluateScript:js];
    context[@"getValues"] = ^(){
        NSArray *arr = [JSContext currentArguments];
        for (NSString *str in arr) {
            NSLog(@"js参数:%@",str);
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
