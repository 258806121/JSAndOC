//
//  JSWay02VC.m
//  JSAndOC
//
//  Created by hb on 2017/3/23.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import "JSWay02VC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSWay02VC ()<
UIWebViewDelegate
>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JSWay02VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"JSWay02" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:htmlPath]];
    [self.webView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"share"] = ^(){
        
        NSLog(@"++++++++++Begin Log++++++++");
        
        NSArray *args = [JSContext currentArguments];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式二" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
            [alertView show];
        });
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@",jsVal.toString);
        }
        
        NSLog(@"++++++++++End Log++++++++");
    };
    
    
}


@end
