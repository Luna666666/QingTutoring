/*
 https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.m
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 5.0 Edition
 BSD License, Use at your own risk
 */

// Thanks to Emanuele Vulcano, Kevin Ballard/Eridius, Ryandjohnson, Matt Brown, etc.

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "UIDevice-Hardware.h"

@implementation UIDevice (Hardware)
/*
 Platforms
 
 iFPGA ->        ??
 
 iPhone1,1 ->    iPhone 1G, A1203
 iPhone1,2 ->    iPhone 3G, A1241, A1324
 iPhone2,1 ->    iPhone 3GS, A1303, A1325
 iPhone3,1 ->    iPhone 4 WCDMA, A1332
 iPhone3,2 ->    iPhone 4 ?, ??
 iPhone3,3 ->    iPhone 4 CDMA2000,A1349
 iPhone4,1 ->    iPhone 4S/AT&T, A1387
 iPhone4,2 ->    iPhone 4S/Verizon), ?
 iPhone5,1 ->    iPhone 5 (GSM/LTE 4, 17/North America), A1428
 iPhone5,2 ->    iPhone 5 (CDMA/LTE, Sprint/Verizon/KDDI), A1429
 iPhone5,3 ->    iPhone 5C A1532, A1456
 iPhone5,4 ->    iPhone 5C A1507, A1526, A1529
 iPhone6,1 ->    iPhone 5S A1533, A1453
 iPhone6,2 ->    iPhone 5S A1457, A1528, A1530
 iPhone7,2 ->    iPhone 6  A1586
 iPhone7,1 ->    iPhone 6 Plus  A1524
 
 iPod1,1   ->    iPod touch 1G, N45
 iPod2,1   ->    iPod touch 2G, N72
 iPod2,2   ->    Unknown, ??
 iPod3,1   ->    iPod touch 3G, N18
 iPod4,1   ->    iPod touch 4G, N80
 iPad5,1   ->    iPod touch 5G
 
 // Thanks NSForge
 iPad1,1   ->    iPad 1G, WiFi and 3G, A1219,A1337
 
 iPad2,1   ->    iPad 2G, WiFi, A1395 (EMC 2415)
 iPad2,2   ->    iPad 2G, WCDMA 3G, A1396
 iPad2,3   ->    iPad 2G, CDMA2000 3G, A1397
 iPad2,4   ->    iPad 2G, WiFi, A1395 (EMC 2560)
 
 iPad2,5   ->    iPad mini, WiFi, A1432
 iPad2,6   ->    iPad mini, WCDMA 3G, A1454
 iPad2,7   ->    iPad mini, CDMA2000 3G, A1455
 
 iPad3,1   ->    iPad 3G, WiFi, A1416
 iPad3,2   ->    iPad 3G, CDMA2000, A1403
 iPad3,3   ->    iPad 3G, WCDMA, A1403
 
 iPad3,4   ->    iPad 4G, WiFi, A1458
 iPad3,5   ->    iPad 4G, WCDMA, A1459
 iPad3,6   ->    iPad 4G, CDMA2000, A1460
 
 iPad4,1   ->    iPad Air(Wi-Fi Only)
 iPad4,2   ->    iPad Air(Wi-Fi Cellular)
 iPad4,4   ->    iPad mini (Retina/2nd Gen - Wi-Fi Only)
 iPad4,5   ->    iPad mini (Retina/2nd Gen - Wi-Fi/Cellular)
 
 AppleTV2,1 ->   AppleTV 2, K66
 
 i386, x86_64 -> iPhone Simulator
 */

/*修改参考网站   (by zhang.zheng, wang.xu_1106)
    http://www.everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html
    https://www.theiphonewiki.com/wiki/Models
 */


#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *) platform
{
    return [self getSysInfoByName:"hw.machine"];
}


// Thanks, Tom Harrington (Atomicbird)
- (NSString *) hwmodel
{
    return [self getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger) cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!
- (NSNumber *) totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *) freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark platform type and name utils
- (NSUInteger) platformType
{
    NSString *platform = [self platform];
    
    //DLog(DT_all, @"get hardware platform == %@", platform);
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"])    return UIDevice5iPhone;
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"])    return UIDevice5CiPhone;
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"])    return UIDevice5SiPhone;
    if ([platform isEqualToString:@"iPhone7,1"])    return UIDevice6PlusiPhone;
    if ([platform isEqualToString:@"iPhone7,2"])    return UIDevice6iPhone;
    if ([platform isEqualToString:@"iPhone8,1"])    return UIDevice6SiPhone;
    if ([platform isEqualToString:@"iPhone8,2"])    return UIDevice6SPlusiPhone;
    if ([platform isEqualToString:@"iPhone8,4"])    return UIDeviceSEiPhone;
    
    //ipone7
    if ([platform isEqualToString:@"iPhone9,1"] ||
        [platform isEqualToString:@"iPhone9,3"])    return UIDevice7iPhone;
    if ([platform isEqualToString:@"iPhone9,2"] ||
        [platform isEqualToString:@"iPhone9,4"])    return UIDevice7PlusiPhone;
    
    //iPone8 & iPhoneX
    if ([platform isEqualToString:@"iPhone10,1"] ||
        [platform isEqualToString:@"iPhone10,4"])   return UIDevice8iPhone;
    if ([platform isEqualToString:@"iPhone10,2"] ||
        [platform isEqualToString:@"iPhone10,5"])   return UIDevice8PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"])   return UIDeviceXiPhone;
    
    //iPoneXS & iPhoneXR
    if ([platform isEqualToString:@"iPhone11,2"])   return UIDeviceXSiPhone;
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"])   return UIDeviceXSMaxiPhone;
    if ([platform isEqualToString:@"iPhone11,8"])   return UIDeviceXRiPhone;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    if ([platform hasPrefix:@"iPod5"])              return UIDevice5GiPod;
    if ([platform hasPrefix:@"iPod7"])              return UIDevice6GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"])      return UIDevice2GiPad;
    
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"])      return UIDevice3GiPad;
    
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"])      return UIDevice4GiPad;
    
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"] ||
        [platform isEqualToString:@"iPad4,3"])      return UIDeviceAiriPad;
    
    if ([platform isEqualToString:@"iPad5,3"] ||
        [platform isEqualToString:@"iPad5,4"])      return UIDeviceAir2iPad;
    
    if ([platform isEqualToString:@"iPad6,3"] ||
        [platform isEqualToString:@"iPad6,4"])      return UIDevicePro9p7InchiPad;
    
    if ([platform isEqualToString:@"iPad6,7"] ||
        [platform isEqualToString:@"iPad6,8"])      return UIDevicePro12p9InchiPad;
    
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"])     return UIDevice5GiPad;

    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"])      return UIDevicePro10p5InchiPad;
    
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"])      return UIDevicePro12p9Inch2GiPad;
    
    if ([platform isEqualToString:@"iPad7,5"] ||
        [platform isEqualToString:@"iPad7,6"])      return UIDevice6GiPad;
    
    if ([platform isEqualToString:@"iPad8,1"] ||
        [platform isEqualToString:@"iPad8,2"] ||
        [platform isEqualToString:@"iPad8,3"] ||
        [platform isEqualToString:@"iPad8,4"])      return UIDevicePro11InchiPad;
    
    if ([platform isEqualToString:@"iPad8,5"] ||
        [platform isEqualToString:@"iPad8,6"] ||
        [platform isEqualToString:@"iPad8,7"] ||
        [platform isEqualToString:@"iPad8,8"])      return UIDevicePro12p9Inch3GiPad;
    
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"])      return UIDeviceiPadmini;
    
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"] ||
        [platform isEqualToString:@"iPad4,6"])      return UIDeviceiPadminiRetina;
    
    if ([platform isEqualToString:@"iPad4,7"] ||
        [platform isEqualToString:@"iPad4,8"] ||
        [platform isEqualToString:@"iPad4,9"])      return UIDeviceiPadmini3;
    
    if ([platform isEqualToString:@"iPad5,1"] ||
        [platform isEqualToString:@"iPad5,2"])      return UIDeviceiPadmini4;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    if ([platform hasPrefix:@"AppleTV5"])           return UIDeviceAppleTV4;
    if ([platform hasPrefix:@"AppleTV6"])           return UIDeviceAppleTV4K;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceiPhoneSimulatoriPhone : UIDeviceiPhoneSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

- (NSString *) platformString
{
    switch ([self platformType])
    {
        case UIDevice1GiPhone:  return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone:  return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone:   return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone:  return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone:   return IPHONE_5_NAMESTRING;
        case UIDevice5CiPhone:  return IPHONE_5C_NAMESTRING;
        case UIDevice5SiPhone:  return IPHONE_5S_NAMESTRING;
        case UIDevice6iPhone:   return IPHONE_6_NAMESTRING;
        case UIDevice6PlusiPhone: return IPHONE_6PLUS_NAMESTRING;
        case UIDevice6SiPhone:  return IPHONE_6S_NAMESTRING;
        case UIDevice6SPlusiPhone: return IPHONE_6SPLUS_NAMESTRING;
        case UIDeviceSEiPhone:  return IPHONE_SE_NAMESTRING;
        case UIDevice7iPhone:   return IPHONE_7_NAMESTRING;
        case UIDevice7PlusiPhone: return IPHONE_7PLUS_NAMESTRING;
        case UIDevice8iPhone:   return IPHONE_8_NAMESTRING;
        case UIDevice8PlusiPhone: return IPHONE_8PLUS_NAMESTRING;
        case UIDeviceXiPhone:   return IPHONE_X_NAMESTRING;
        case UIDeviceXSiPhone:  return IPHONE_XS_NAMESTRING;
        case UIDeviceXSMaxiPhone: return IPHONE_XSMAX_NAMESTRING;
        case UIDeviceXRiPhone:  return IPHONE_XR_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod: return IPOD_5G_NAMESTRING;
        case UIDevice6GiPod: return IPOD_6G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
        case UIDeviceAiriPad : return IPAD_AIR_NAMESTRING;
        case UIDeviceAir2iPad : return IPAD_AIR2_NAMESTRING;
        case UIDevicePro9p7InchiPad : return IPAD_PRO9P7INCH_NAMESTRING;
        case UIDevicePro12p9InchiPad : return IPAD_PRO12P9INCH_NAMESTRING;
        case UIDevice5GiPad : return IPAD_5G_NAMESTRING;
        case UIDevicePro10p5InchiPad : return IPAD_PRO10P5INCH_NAMESTRING;
        case UIDevicePro12p9Inch2GiPad : return IPAD_PRO12P9INCH2G_NAMESTRING;
        case UIDevice6GiPad : return IPAD_6G_NAMESTRING;
        case UIDevicePro11InchiPad : return IPAD_PRO11INCH_NAMESTRING;
        case UIDevicePro12p9Inch3GiPad : return IPAD_PRO12P9INCH3G_NAMESTRING;
        case UIDeviceiPadmini : return IPAD_MINI_NAMESTRING;
        case UIDeviceiPadminiRetina : return IPAD_MINI_RETINA_NAMESTRING;
        case UIDeviceiPadmini3 : return IPAD_MINI3_NAMESTRING;
        case UIDeviceiPadmini4 : return IPAD_MINI4_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceAppleTV4K : return APPLETV_4K_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceiPhoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
        case UIDeviceiPhoneSimulatoriPhone: return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceiPhoneSimulatoriPad: return IPHONE_SIMULATOR_IPAD_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
- (NSString *) macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    // NSString *outstring = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X", 
    //                       *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *) osLanguageAndCountry 
{
    NSString * locale = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLocale"];
    return locale;
}

// Illicit Bluetooth check -- cannot be used in App Store
/* 
 Class  btclass = NSClassFromString(@"GKBluetoothSupport");
 if ([btclass respondsToSelector:@selector(bluetoothStatus)])
 {
 printf("BTStatus %d\n", ((int)[btclass performSelector:@selector(bluetoothStatus)] & 1) != 0);
 bluetooth = ((int)[btclass performSelector:@selector(bluetoothStatus)] & 1) != 0;
 printf("Bluetooth %s enabled\n", bluetooth ? "is" : "isn't");
 }
 */
@end
