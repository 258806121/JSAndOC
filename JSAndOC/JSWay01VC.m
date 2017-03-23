//
//  JSWay01VC.m
//  JSAndOC
//
//  Created by hb on 2017/3/23.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//


/**
 注意：1. JS中的firstClick,在拦截到的url scheme全都被转化为小写。
 2.html中需要设置编码，否则中文参数可能会出现编码问题。
 3.JS用打开一个iFrame的方式替代直接用document.location的方式，以避免多次请求，被替换覆盖的问题。
 */

#import "JSWay01VC.h"

@interface JSWay01VC ()<
UIWebViewDelegate
>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JSWay01VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"JSWay01" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:htmlPath]];
    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    
    if ([[url scheme] isEqualToString:@"firstclick"]) {
        
        NSArray *params =[url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式一" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"tempDic:%@",tempDic);
        return NO;
    }
    
    return YES;
}


@end
