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
    var submitTrigger : PublishSubject<Void> { get }
}
// output
protocol CalculatorViewModelOutputs {
    var calculationText: Driver<String> { get }
}

protocol CalculatorViewModelType {
    var inputs: CalculatorViewModelInputs { get }
    var outputs: CalculatorViewModelOutputs { get }
}

class CalculatorViewModel : CalculatorViewModelInputs, CalculatorViewModelOutputs, CalculatorViewModelType {
    
    var inputs : CalculatorViewModelInputs { return self }
    var outputs : CalculatorViewModelOutputs { return self }
    
    // MARK: - Input
    let submitTrigger = PublishSubject<Void>()
    
    // MARK: - Output
    let calculationText : Driver<String>

    let disposeBag = DisposeBag()
    
    private let numberSum = BehaviorRelay<Int>(value: 0)
    
    var number = 0
    
    init() {
        
        submitTrigger
            .subscribe(onNext: { _ in
                //number = number + button.tag
                
                //calculationResultLabel.text = "\(number)"
                print("タップしたよ！")
                
            })
            .disposed(by: disposeBag)
        
        calculationText = numberSum
            .map { String("\(Double($0) / 10)") }
            .asDriver(onErrorDriveWith: .empty())
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onCompleted()
            return Disposables.create()
        }
        
    }
         
    
    func aaa () {
        print("aaaを呼び出し")
    }
    
    
}
