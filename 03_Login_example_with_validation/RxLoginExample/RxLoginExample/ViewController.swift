//
//  ViewController.swift
//  RxLoginExample
//
//  Created by Apple on 27/01/21.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak  var txtPassword : UITextField!
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var lblStatus : UILabel!
    
    var loginViewModal = LoginViewModal()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        
        _ = txtEmail.rx.text.map { $0 ?? ""}.bind(to: loginViewModal.emailText)
        _ = txtPassword.rx.text.map { $0 ?? ""}.bind(to: loginViewModal.passwordText)
        
       _ = loginViewModal.isValid.bind(to: btnLogin.rx.isEnabled)
        _ = loginViewModal.isValid.subscribe(onNext: { [weak self] status in
            self?.lblStatus?.text = status ? "Enabled" : "Not Enabled"
            self?.lblStatus?.textColor = status ? UIColor.green : UIColor.red
        }).disposed(by: bag)
    
    }
}




