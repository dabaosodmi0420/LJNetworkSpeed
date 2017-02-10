//
//  LJNetworkTool.h
//  LJReactiveCocoa
//
//  Created by Apple on 2017/2/10.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNetworkTool : NSObject

+ (instancetype)shareNetworkTool;

- (NSString *)getInterfaceBytes;

@end
