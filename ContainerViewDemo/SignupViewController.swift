//
//  SignupViewController.swift
//  ContainerViewDemo
//
//  Created by Christian Iñigo De Leon Alvarez on 6/7/20.
//  Copyright © 2020 Christian Iñigo De Leon Alvarez. All rights reserved.
//

import UIKit

protocol SignupModule {
    var wantsToGoToLoginScreen: (() -> Void)? { get set }
}

class SignupViewController: UIViewController, SignupModule, AuthModule {
    var wantsToChangeModel: ((String) -> Void)?

    var wantsToGoToLoginScreen: (() -> Void)?
    
    @IBAction func switchToLoginButtonTapped(_ sender: UIButton) {
        self.wantsToGoToLoginScreen?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.wantsToChangeModel?("Signup lah")
    }

}
