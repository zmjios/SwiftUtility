//
//  TestKVO.swift
//  SwiftUtility
//
//  Created by zmjios on 16/3/21.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import Foundation

protocol PropertyObservable{
    
    associatedtype PropertyType
    var propertyChanged:Event<PropertyType>{ get }
}

enum CarProperty{
    case Miles, Name
}

class MyCar:PropertyObservable{
    typealias PropertyType = CarProperty
    
    let propertyChanged = Event<CarProperty>()
    
    dynamic var miles:Int = 0{
        didSet{
            propertyChanged.raise(.Miles)
        }
    }
    
    dynamic var name:String = "Turbo"{
        didSet{
            propertyChanged.raise(.Name)
        }
    }
    
}