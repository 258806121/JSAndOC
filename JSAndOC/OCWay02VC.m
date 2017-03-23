//
//  OCWay02VC.m
//  JSAndOC
//
//  Created by hb on 2017/3/23.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

/*
 重点：
 stringByEvaluatingJavaScriptFromString是一个同步的方法，使用它执行JS方法时，如果JS 方法比较耗的时候，会造成界面卡顿。尤其是js 弹出alert 的时候。
 alert 也会阻塞界面，等待用户响应，而stringByEvaluatingJavaScriptFromString又会等待js执行完毕返回。这就造成了死锁。
 官方推荐使用WKWebView的evaluateJavaScript:completionHandler:代替这个方法。
 其实我们也有另外一种方式，自定义一个延迟执行alert 的方法来防止阻塞，然后我们调用自定义的alert 方法。同理，耗时较长的js 方法也可以放到setTimeout 中。
 
 function asyncAlert(content) {
 setTimeout(function(){
 alert(content);
 },1);
 }
 
 **/

#import "OCWay02VC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCWay02VC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OCWay02VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"OCWay02" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:htmlPath]];
    [self.webView loadRequest:request];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"调用JS" style:UIBarButtonItemStylePlain target:self action:@selector(OCToJS)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)OCToJS
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
    [context evaluateScript:textJS];
}


@end
