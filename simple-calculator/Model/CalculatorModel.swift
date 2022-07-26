//
//  CalculatorModel.swift
//  simple-calculator
//
//  Created by 横山　賢一 on 2022/07/15.
//

import RxSwift
import RxCocoa

class CalculatorModel {

    var valueRelay = BehaviorRelay<String>(value: "")
    //今回の値
    var thisValueStr:String = ""
    //合計値
    var sumValueStr:String = ""
    //押されている記号
    var symbolTapped: Int = 0  //0:無し, 1: +, 2: -, 3: ×, 4: ÷, 5
    
    func numEntry(num: Int) {
        
        var value = valueRelay.value
        value = thisValueStr
        
        let numStr: String = String(num)
        
        let valueStr2 = value + numStr
        //今回
        thisValueStr = valueStr2
        
        valueRelay.accept(thisValueStr)
        
    }
    
    func symbolEntry(num: Int)  {
        
        var value = valueRelay.value
        value = thisValueStr
        
        switch num {
        case 11:
            print("tap: =")
            
            beforeSymbolTapped()
            
        case 12:
            print("tap: +")
            
            beforeSymbolTapped()
            symbolTapped = 1 //足し算
            
        case 13:
            print("tap: -")
            
            beforeSymbolTapped()
            symbolTapped = 2 //引き算
            
        case 14:
            print("tap: ×")
            beforeSymbolTapped()
            symbolTapped = 3 //掛け算
            
            
        case 15:
            print("tap: ÷")
            beforeSymbolTapped()
            symbolTapped = 4 //割り算
            
            
        case 16:
            print("tap: %")
        case 17:
            print("tap: ±")
            
        case 18:
            print("tap: C")
            symbolTapped = 0
            thisValueStr = ""
            sumValueStr = ""
            valueRelay.accept("0")
            
        default:
            print("tap: .")
            print("value: \(value)")
            
            let valueStr: String = String(value)
            let flg: Bool = valueStr.contains(".")
            guard flg == false else {
                return
            }
            let valueStr2 = valueStr + "."
            valueRelay.accept(valueStr2)
        }
         
    }
    
    func beforeSymbolTapped() {
        
        switch symbolTapped {
        case 1:
            let thisValue = Int(thisValueStr)!
            var sumValue = Int(sumValueStr)!
            sumValue = sumValue + thisValue
            valueRelay.accept(String(sumValue))
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(sumValue)
        case 2:
            let thisValue = Int(thisValueStr)!
            var sumValue = Int(sumValueStr)!
            sumValue = sumValue - thisValue
            valueRelay.accept(String(sumValue))
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(sumValue)
        case 3:
            let thisValue = Int(thisValueStr)!
            var sumValue = Int(sumValueStr)!
            sumValue = sumValue * thisValue
            valueRelay.accept(String(sumValue))
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(sumValue)
        case 4:
            let thisValue = Int(thisValueStr)!
            //let thisValue = (thisValueStr as NSString).integerValue
            var sumValue = Int(sumValueStr)!
            sumValue = sumValue / thisValue
            valueRelay.accept(String(sumValue))
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(sumValue)
        default:
            let thisValue = Int(thisValueStr)!
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(thisValue)
            return
        }
    }
    
    
}
