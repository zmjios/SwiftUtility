//
//  ViewController.swift
//  SwiftUtility
//
//  Created by zmjios on 16/2/28.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import UIKit

class Car: NSObject {
    dynamic var miles = 0
    dynamic var name = "Turbo"
}

class CarObserver:NSObject {
    private var kvoContext:UInt8 = 1
    
    private let car:Car
    
    init(_ car:Car) {
        self.car = car
        super.init()
        car.addObserver(self, forKeyPath: "miles", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        
    }
    
    func changeValue()
    {
        self.car.miles = 100
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let change = change where context == &kvoContext{
            
            let a = change[NSKeyValueChangeNewKey]
            
            print("Change at keyPath = \(keyPath) for \(object),new is \(a)")
            
        }
    }
    
    
    deinit{
        car.removeObserver(self, forKeyPath: "miles")
    }
}

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        testOptional();
        
//        testKVO()
        
        testFun1()
        
        testKvo1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func testOptional(){
        
        let a: Int? = 1
        let b: Int?? = a
        let c: Int??? = b
        
        
        print(c);
        
    }
    
    
    func testKVO()
    {
        let car = Car()
        let carTest = CarObserver(car)
        carTest.changeValue()
        
    }
    
    
    func testFun1(){
        
        let account = BankAccount()
        account.deposit(100) // balance is now 100
        
        let depositor = BankAccount.deposit
        depositor(account)(100) // balance is now 200
    }
    
    
    func testKvo1(){
        
        let car = MyCar()
        car.propertyChanged.addHandler(self, handler:ViewController.onPropertyChange)
        car.miles = 34
    }

    
    func onPropertyChange(property:CarProperty){
        print("A car property changed!")
    }

}



class BankAccount {
    var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
        print("balcance = \(balance)")
    }
}



