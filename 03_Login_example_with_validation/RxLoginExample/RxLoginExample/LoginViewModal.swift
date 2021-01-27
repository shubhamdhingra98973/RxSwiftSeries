//
//  LoginViewModal.swift
//  RxLoginExample
//
//  Created by Apple on 27/01/21.
//

import Foundation
import RxSwift
import RxRelay

struct LoginViewModal {
    var emailText = BehaviorRelay<String>(value : "")
    var passwordText = BehaviorRelay<String>(value : "")
    
    var isValid : Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email , password in
            email.count > 3 && password.count > 2
        }
    }
    
}
