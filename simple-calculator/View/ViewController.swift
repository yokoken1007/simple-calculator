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
    @IBOutlet var symbolButtons: [UIButton]!
    
    private let disposeBag = DisposeBag()
    private let viewModel: CalculatorViewModelType = CalculatorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        
    }
    
    func setupBinding() {
        //数字ボタンタップ
        numberButtons.forEach{ button in
            button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    guard let _self = self else { return }
                    _self.viewModel.inputs.didTapNumberButton(tag: button.tag)
                })
                .disposed(by: disposeBag)
        }
        
        //記号ボタンタップ
        symbolButtons.forEach{ button in
            button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    guard let _self = self else { return }
                    _self.viewModel.inputs.didTapSymbolButton(tag: button.tag)
                })
                .disposed(by: disposeBag)
        }
        
        //計算結果ラベル
        viewModel.outputs.calculationText
            .drive(calculationResultLabel.rx.text)
            .disposed(by: disposeBag)
    }


}

