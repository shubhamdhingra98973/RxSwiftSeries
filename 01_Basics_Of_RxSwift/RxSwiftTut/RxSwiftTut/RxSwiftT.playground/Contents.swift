import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
let names = BehaviorSubject(value: ["Peter"])
do {
try names.value()
}
catch (_) {
    
}
names.asObservable()
//    .throttle(0.5, scheduler: MainScheduler.instance)
    .filter{ value in
        value.count > 1
    }
    .map{value in
        return "Users : " + value.description
    }
    .subscribe(onNext: { value in
       print(value)
    })
do {
    try names.onNext(names.value() + ["John"])
    names.onNext(["Alice" , "Wendy"])

    names.onNext(["Admin"])// concatenating older value with new
} catch {
    print(error)
}


