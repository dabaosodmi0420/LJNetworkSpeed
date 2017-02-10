
//
//  LJNetworkTool.m
//  LJReactiveCocoa
//
//  Created by Apple on 2017/2/10.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJNetworkTool.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation LJNetworkTool{
    long long _aboveBytes;
}

+ (instancetype)shareNetworkTool{
    static LJNetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[LJNetworkTool alloc]init];
    });
    return tool;
}

/*获取网络流量信息*/
- (NSString *)getInterfaceBytes
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return 0;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);

    if (_aboveBytes == 0) {
        _aboveBytes = iBytes + oBytes;
        return @"0B";
    }
    long long currentBytes = iBytes + oBytes - _aboveBytes;
    _aboveBytes = iBytes + oBytes;

    if (currentBytes < 1024) {
        return [NSString stringWithFormat:@"%lldB",currentBytes];
    }else if (currentBytes < 1024 * 1024){
        return [NSString stringWithFormat:@"%.2fKB",currentBytes / 1024.0];
    }else{
        return [NSString stringWithFormat:@"%.2fM",currentBytes / 1024.0 / 1024.0];
    }
}
@end
