//
//  ViewController.swift
//  simple-calculator
//
//  Created by 横山　賢一 on 2022/07/01.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var calculationResultLabel: UILabel!
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet var numberButton0: UIButton!
    @IBOutlet var numberButton1: UIButton!
    @IBOutlet var numberButton2: UIButton!
    @IBOutlet var numberButton3: UIButton!
    @IBOutlet var numberButton4: UIButton!
    @IBOutlet var numberButton5: UIButton!
    @IBOutlet var numberButton6: UIButton!
    @IBOutlet var numberButton7: UIButton!
    @IBOutlet var numberButton8: UIButton!
    @IBOutlet var numberButton9: UIButton!
    @IBOutlet var periodButton: UIButton!
     
    
    let disposeBag = DisposeBag()
    let viewModel = CalculatorViewModel()
    
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        test()
        
    }
    
    func bind() {
        
        numberButtons.forEach{ button in
            button.rx.tap.asDriver()
                .drive(viewModel.inputs.submitTrigger)
                .disposed(by: disposeBag)
        }
        
        /*
        for num in numberButtons {  //　→ 0...10 ではなく 配列要素数全て繰り返す
            num.rx.tap.asDriver()
                .drive(onNext: { [self] in
                    number = number + num.tag
                    calculationResultLabel.text = "\(number)"
                })
                .disposed(by: disposeBag)
        }
         */
        
        viewModel.outputs.calculationText
            .drive(calculationResultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func test () {
        numberButton7.rx.tap.asDriver() // numberButton7ボタンをタップした時の動作を監視する　asDriverでUIbuttonをdriveメソッドに変換できる
            .drive(onNext: { [self] in // .driveで処理実行　　　[self]でオブジェクトのselfを省略できる
                number = number + numberButton7.tag
                calculationResultLabel.text = "\(number)"
            }).disposed(by: disposeBag)
        
        
    }


}

