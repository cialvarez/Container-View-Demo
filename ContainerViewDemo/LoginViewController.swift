//
//  LoginViewController.swift
//  ContainerViewDemo
//
//  Created by Christian Iñigo De Leon Alvarez on 6/7/20.
//  Copyright © 2020 Christian Iñigo De Leon Alvarez. All rights reserved.
//

import UIKit

protocol LoginModule {
    var wantsToGoToSignupScreen: (() -> Void)? { get set }
}

class LoginViewController: UIViewController, LoginModule, AuthModule {
    
    var wantsToGoToSignupScreen: (() -> Void)?
    var wantsToChangeModel: ((_ text: String) -> Void)?
    
    @IBAction func switchToSignupButtonTapped(_ sender: UIButton) {
        wantsToGoToSignupScreen?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.wantsToChangeModel?("Login lah")
    }
}
