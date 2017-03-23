//
//  OCWay01VC.m
//  JSAndOC
//
//  Created by hb on 2017/3/23.
//  Copyright © 2017年 com.bm.hb. All rights reserved.
//

#import "OCWay01VC.h"

@interface OCWay01VC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OCWay01VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"OCWay01" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:htmlPath]];
    [self.webView loadRequest:request];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"调用JS" style:UIBarButtonItemStylePlain target:self action:@selector(OCToJS)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)OCToJS
{
    NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"这里是JS中alert弹出的message"];
    [_webView stringByEvaluatingJavaScriptFromString:jsStr];
}






@end
