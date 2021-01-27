//
//  StockPrice.swift
//  WenderStock
//
//  Created by Apple on 27/01/21.
//

import Foundation
import RxSwift
import RxCocoa

class StockPrice {
    
    public let symbol : String
    public var isfavorite : Bool = false
    
    let price = BehaviorSubject<Double>(value: 0)
    var priceObservable : Observable<Double> {
        return price.asObservable()
    }
    
    init(symbol : String , favorite : Bool) {
        self.symbol = symbol
        self.isfavorite = favorite
    }
    
    func update(price : Double) {
        self.price.onNext(price)
    }
}
