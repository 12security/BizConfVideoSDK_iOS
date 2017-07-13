//
//  ToShareViewController.m
//  SDKDemo
//
//  Created by Colin on 2017/6/6.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "ToShareViewController.h"
#import <BizConfSDK/BizConfSDK.h>
@interface ToShareViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ToShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.slider add
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, 375, 500)];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.opaque = NO;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    [self loadFile];
}
//- (UIWebView *)webView{
//
//    if (!_webView) {
//        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
//        [_webView scalesPageToFit];
//    }
//    return _webView;
//}

- (void)loadFile
{
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"精通iOS框架(第2版)" ofType:@"pdf"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.webView loadRequest:request];
}- (IBAction)onClickStopShare:(id)sender {
    [[BizConfVideoSDK sharedSDK]stopSharingScreen];
}
- (IBAction)onSliderValueChanged:(id)sender {
    self.lbValue.text = [NSString stringWithFormat:@"%f %%",self.slider.value*100];
}

@end
