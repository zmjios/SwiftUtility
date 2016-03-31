//
//  NSString+Security.m
//  SwiftUtility
//
//  Created by zmjios on 16/3/31.
//  Copyright © 2016年 zmjios. All rights reserved.
//

#import "NSString+Security.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Security)

- (NSString *)stringFromMD5
{
    
    if (self.length < 1)
    {
        return nil;
    }
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (unsigned int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString *)stringFromMD5_16
{
    NSString *str = [self stringFromMD5];
    
    return nil != str ? [str substringWithRange:NSMakeRange(8, 16)] : str;
}

@end
