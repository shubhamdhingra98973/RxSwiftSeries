//
//  ViewController.swift
//  WenderStock
//
//  Created by Apple on 27/01/21.
//

import UIKit
import RxSwift


class ViewController: UIViewController {

    //MARK::- properties
    fileprivate var bag = DisposeBag()
    
    //input
    fileprivate var allSymbols = ["RZW" , "UDP" , "MTT" , "ZKQ", "IPK","EQU"]
    fileprivate var allPrices = BehaviorSubject<[StockPrice]>(value:[
        StockPrice(symbol: "RZW", favorite: false),
        StockPrice(symbol: "UDP", favorite: true),
        StockPrice(symbol: "MTT", favorite: false),
        StockPrice(symbol: "ZKQ", favorite: true),
        StockPrice(symbol: "IPK", favorite: false),
        StockPrice(symbol: "EQU", favorite: true)
    ])
    
    //output
    fileprivate var prices = BehaviorSubject<[StockPrice]>(value:[
        StockPrice(symbol: "RZW", favorite: false),
        StockPrice(symbol: "UDP", favorite: true),
        StockPrice(symbol: "MTT", favorite: false),
        StockPrice(symbol: "ZKQ", favorite: true),
        StockPrice(symbol: "IPK", favorite: false),
        StockPrice(symbol: "EQU", favorite: true)
    ])

    //MARK::- Outlets
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var search : UITextField!
    @IBOutlet weak var btnSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        Observable.combineLatest(allPrices.asObservable(), btnSwitch.rx.isOn, search.rx.text , resultSelector: {currentPrices, onlyfavorites, search in
            return currentPrices.filter{ price -> Bool in
               return self.showDisplayPrice(price: price, onlyfavorites: onlyfavorites, search: search)
            }
        }).bind(to: prices)
        .disposed(by: bag)
        
        prices.asObservable().subscribe(onNext:{ value in
            self.tableView.reloadData()
            }
        ).disposed(by: bag)
    }


}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
        return try self.prices.value().count
        }
        catch(_) {
            
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as? StockCell else {
            return UITableViewCell()
        }
        do {
            try cell.update(self.prices.value()[indexPath.row])
            return cell
        }
        catch(_) {
            
        }
        return UITableViewCell()
    }
    
}

extension ViewController {
    fileprivate func showDisplayPrice(price : StockPrice , onlyfavorites : Bool , search : String?) -> Bool {
        if !price.isfavorite && onlyfavorites {
            return false
        }
        
        if let search = search , !search.isEmpty , !price.symbol.contains(search) {
            return false
        }
        return true
        
    }
    
    fileprivate func update(prices : [StockPrice] ,with newPrices : [String : Double]) -> [StockPrice] {
        for (key , newPrice) in newPrices {
            if let stockPrice = prices.filter({$0.symbol == key
            }).first {
                stockPrice.update(price: newPrice)
            }
        }
        return prices
    }
}

