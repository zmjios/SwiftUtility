//
//  TCDebugButton.swift
//  SwiftUtility
//
//  Created by zmjios on 16/3/28.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import Foundation
import UIKit

typealias ActionBlock = ()->Void

struct TCDebugStruct {
    static let TCDebugButtonTag = 19999
}

class TCDebugButton: UIView {
    var bgImage:UIImage?{
        
        didSet{
            
            let imageView = self.viewWithTag(TCDebugStruct.TCDebugButtonTag)
            var frame = imageView?.frame
            frame?.size.width = (bgImage?.size.width)!
            frame?.size.height = (bgImage?.size.height)!
            self.bounds = frame!
            
        }
    }
    var actionBlock:ActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
   convenience init(image:UIImage,clickBlock:ActionBlock?){
    self.init(frame:CGRectMake(0, 0, image.size.width, image.size.height))
    self.actionBlock = clickBlock
    
    let imageView = UIImageView(image: image)
    imageView.frame = self.bounds
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.userInteractionEnabled = true
    imageView.tag = TCDebugStruct.TCDebugButtonTag
    self.addSubview(imageView)
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(TCDebugButton.handleTapGesture(_:)))
    self.addGestureRecognizer(tapGesture)
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: gesture
    func handleTapGesture(gesture:UITapGestureRecognizer) -> () {
        if self.actionBlock != nil {
            self.actionBlock!()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let prePoint = touch.preciseLocationInView(self.superview)
        let nowPoint = touch.locationInView(self.superview)
        let offset = CGPointMake(nowPoint.x-prePoint.x, nowPoint.y-prePoint.y)
        
        self.center = CGPointMake(self.center.x+offset.x, self.center.y+offset.y)
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        //
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
    }
    
    
}


