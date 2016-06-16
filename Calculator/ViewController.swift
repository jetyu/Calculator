//
//  ViewController.swift
//  Calculator
//
//  Created by Jet on 16/5/25.
//  Copyright © 2016年 Jet. All rights reserved.
//

import UIKit
//在swift里，当一个对象初始化了，那么这个对象的所有属性都必须要初始化。
class ViewController: UIViewController {
// 这里定义了一个类
    @IBOutlet weak var display: UILabel!
//创建label的property的语法的示例，uilabel是他的类型
//outlet和action区别，outlet说明是一个是实例变量，而action说明是创建的一个方法。

    //获取数字键盘上的值的方法
    var userInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    @IBAction func appendDigit(sender: UIButton)  {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
             display.text = display.text! + digit
        }else{
             display.text = digit
             userInTheMiddleOfTypingANumber = true
        }
        print("digit = \(digit)")
//optional:一般由问号？组成的。只有2个值，一种叫notset，未设状态，nil，另一种教：有值，
//!的意思：！用来解包optional类型的值，如果没有设值，nil状态的话，app就会crash，所以对于optional类型的常量，要用！来解包
    }
    
    //加减乘除的方法
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0.0
                //将结果显示为0
            }
        }
    }
//swift现在已经不支持两个相同函数名的函数了，所以需要将开根号的那个方法名修改一下。
    //enter的获取方法
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            //将string类型转换为double
            userInTheMiddleOfTypingANumber = false
        }
    }
}

