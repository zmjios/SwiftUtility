//
//  Devices.swift
//  SwiftUtility
//
//  Created by zmjios on 16/3/25.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import Foundation
import UIKit


// MARK: screen info

struct ScreenSize {
    static let ScreenWidth          = UIScreen.mainScreen().bounds.size.width
    static let ScreenHeith          = UIScreen.mainScreen().bounds.size.height
    static let ScreenScale          = UIScreen.mainScreen().scale
    static let ScreenMaxLength      = max(ScreenSize.ScreenWidth, ScreenSize.ScreenHeith)
    static let ScreenMinLength      = min(ScreenSize.ScreenWidth, ScreenSize.ScreenHeith)
}


// MARK:  sysetem version
struct iOSVersion {
    
    static let IOS7Beolow   = UIDevice.SYSTEM_VERSION_LESS_THAN("7.0")
    static let IOS7         = UIDevice.SYSTEM_VERSION_LESS_THAN("8.0") && UIDevice.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("7.0")
    static let IOS8         = UIDevice.SYSTEM_VERSION_LESS_THAN("9.0") && UIDevice.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")
    static let IOS9         = UIDevice.SYSTEM_VERSION_LESS_THAN("10.0") && UIDevice.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("9.0")
    
}

/** Model Extends UIDevice */
extension UIDevice {
    
    //systeme version compare methods
    
    class func SYSTEM_VERSION_EQUAL_TO(version: NSString) -> Bool {
        return self.currentDevice().systemVersion.compare(version as String,
                                                          options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
    }
    
    class func SYSTEM_VERSION_GREATER_THAN(version: NSString) -> Bool {
        return self.currentDevice().systemVersion.compare(version as String,
                                                          options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    class func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
        return self.currentDevice().systemVersion.compare(version as String,
                                                          options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
    }
    
    class func SYSTEM_VERSION_LESS_THAN(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
    }
    
    class func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: NSString) -> Bool {
        return self.currentDevice().systemVersion.compare(version as String,
                                                          options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
    }
    
}



