//
//  CalculatorViewModel.swift
//  simple-calculator
//
//  Created by 横山　賢一 on 2022/07/07.
//

import RxSwift
import RxCocoa

// input
protocol CalculatorViewModelInputs {
    func didTapNumberButton(tag: Int)
    func didTapSymbolButton(tag: Int)
}
// output
protocol CalculatorViewModelOutputs {
    var calculationText: Driver<String> { get }
}

protocol CalculatorViewModelType {
    var inputs: CalculatorViewModelInputs { get }
    var outputs: CalculatorViewModelOutputs { get }
}

class CalculatorViewModel: CalculatorViewModelInputs, CalculatorViewModelOutputs {

    private let disposeBag = DisposeBag()
    private let textRelay = BehaviorRelay<String>(value: "0")
    
    let model = CalculatorModel()
    
    init() {
        setupBinding()
    }
    
    func setupBinding() {
        model.valueRelay
            //.map { String($0) }
            .bind(to: textRelay)
            .disposed(by: disposeBag)
    }
    
    var calculationText: Driver<String> {
        textRelay.asDriver()
    }
    
    func didTapNumberButton(tag:Int) {
        
        model.numEntry(num: tag)
    }
    
    func didTapSymbolButton(tag: Int) {
        
        model.symbolEntry(num: tag)
    }
}

enum CalculatorSymbol: Int {
    case dot = 10
    case equal = 11
    case plus = 12
    case minus = 13
    case multiply = 14
    case divide = 15
    case percent = 16
    case plusminus = 17
    case clear = 18
}

extension CalculatorViewModel: CalculatorViewModelType {
    var inputs: CalculatorViewModelInputs { return self }
    var outputs: CalculatorViewModelOutputs { return self }
}

