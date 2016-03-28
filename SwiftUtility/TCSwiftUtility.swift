//
//  TCSwiftUtility.swift
//  SwiftUtility
//
//  Created by zmjios on 16/2/28.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import UIKit

class TCSwiftUtility: NSObject {
    
    
    /**
     计算函数计算时间
     
     - parameter f: <#f description#>
     
     使用简介：
     
     TCSwiftUtility.measure {
     doSomeHeavyWork()
     }
     
     */
    static func measure(f: ()->()) {
        let start = CACurrentMediaTime()
        f()
        let end = CACurrentMediaTime()
        print("测量时间：\(end - start)")
    }
    
    
    static func dPrint(@autoclosure item: () -> Any) {
        #if DEBUG
            print(item())
        #endif
    }
    
    
    

}


extension Optional {
    func withExtendedLifetime(body: Wrapped -> Void) {
        if let strongSelf = self {
            body(strongSelf)
        }
    }
}
