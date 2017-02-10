//
//  ViewController.m
//  获取网络速度
//
//  Created by Apple on 2017/2/10.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "ViewController.h"
#import "LJNetworkTool.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@interface ViewController ()
/**  */
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 40)];
    _label.backgroundColor = [UIColor yellowColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    // Do any additional setup after loading the view, typically from a nib.
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getInternetface) userInfo:nil repeats:YES];
    
    [timer fireDate];
    
    [self getPhoneCardInfo];
}
/** 获取手机运营商信息 */
- (void)getPhoneCardInfo{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];

    CTCarrier *carrier = [netInfo subscriberCellularProvider];

    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    NSString *mcc = [carrier mobileCountryCode];

    NSString *mnc = [carrier mobileNetworkCode];

    NSLog(@"%@,%@",mcc,mnc);

}


- (void)getInternetface {
    LJNetworkTool *tool = [LJNetworkTool shareNetworkTool];
    NSString *str = [tool getInterfaceBytes];
    _label.text = str;
    NSLog(@"%@",str);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
