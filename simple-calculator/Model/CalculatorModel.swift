//
//  CalculatorModel.swift
//  simple-calculator
//
//  Created by 横山　賢一 on 2022/07/15.
//

import RxSwift
import RxCocoa

class CalculatorModel {

    var valueRelay = BehaviorRelay<String>(value: "0")
    //今回の値
    var thisValueStr:String = ""
    //合計値
    var sumValueStr:String = ""
    //押されている記号
    var symbolTapped: Int = 0  //0:無し, 1: +, 2: -, 3: ×, 4: ÷, 5
    //記号ダブルタップ防止
    var symbolTapFlg: Bool = false
    
    func numEntry(num: Int) {
        
        var value = valueRelay.value
        value = thisValueStr
        
        let numStr: String = String(num)
        
        let valueStr2: String
        if num < 10 {
            print("tap: \(num)")
            valueStr2 = value + numStr
        } else {
            // .
            print("tap: .")
            let valueStr: String = String(value)
            let flg: Bool = valueStr.contains(".")
            guard flg == false else {
                return
            }
            valueStr2 = valueStr + "."
        }
        
        thisValueStr = valueStr2
        valueRelay.accept(thisValueStr)
        
        //記号タップOK
        symbolTapFlg = false
        
    }
    
    func symbolEntry(num: Int)  {
        
        if num == 18 {
            //クリア
            print("tap: C")
            symbolTapped = 0
            thisValueStr = ""
            sumValueStr = ""
            valueRelay.accept("0")
        } else {
            if symbolTapFlg == false {
                beforeSymbolTapped()
            }
            switch num {
            case 11:
                print("tap: =")
                symbolTapped = 0 //クリア
            case 12:
                print("tap: +")
                symbolTapped = 1 //足し算
            case 13:
                print("tap: -")
                symbolTapped = 2 //引き算
            case 14:
                print("tap: ×")
                symbolTapped = 3 //掛け算
            case 15:
                print("tap: ÷")
                symbolTapped = 4 //割り算
            case 16:
                print("tap: %")
            case 17:
                print("tap: ±")
                
            default:
                return
            }
        }
        
        //記号タップNG
        symbolTapFlg = true
         
    }
    
    func beforeSymbolTapped() {
        
        if symbolTapped > 0 {
            let thisValue = Double(thisValueStr)!
            var sumValue = Double(sumValueStr)!
            switch symbolTapped {
            case 1:
                sumValue = sumValue + thisValue
            case 2:
                sumValue = sumValue - thisValue
            case 3:
                sumValue = sumValue * thisValue
            case 4:
                sumValue = sumValue / thisValue
            default:
                return
            }
            
            let decimal1 = sumValue.truncatingRemainder(dividingBy: 1)
            if decimal1 == 0.0 {
                valueRelay.accept(String(Int(sumValue)))
            } else {
                valueRelay.accept(String(sumValue))
            }
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(sumValue)
                
        } else {
            //初回
            let thisValue = Double(thisValueStr)!
            //今回の値をクリア
            thisValueStr = ""
            //合計を格納
            sumValueStr = String(thisValue)
        }
        
    }
    
}
