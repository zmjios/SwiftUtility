//
//  Event.swift
//  SwiftUtility
//
//  Created by zmjios on 16/3/21.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import Foundation

public class Event<T> {
    
    public typealias EventHandler = T -> ()
    
    private var eventHandlers = [Invocable]()
    
    public func raise(data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data)
        }
    }
    
    public func addHandler<U: AnyObject>(target: U,
        handler: (U) -> EventHandler) -> Disposable {
            let wrapper = EventHandlerWrapper(target: target,
                handler: handler, event: self)
            eventHandlers.append(wrapper)
            return wrapper
    }
}

private protocol Invocable: class {
    func invoke(data: Any)
}



private class EventHandlerWrapper<T: AnyObject, U>
: Invocable, Disposable {
    weak var target: T?
    let handler: T -> U -> ()
    let event: Event<U>
    
    init(target: T?, handler: T -> U -> (), event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event;
    }
    
    func invoke(data: Any) -> () {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    func dispose() {
        event.eventHandlers =
            event.eventHandlers.filter { $0 !== self }
    }
}

public protocol Disposable {
    func dispose()
}