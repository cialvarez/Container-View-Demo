//
//  ViewController.swift
//  ContainerViewDemo
//
//  Created by Christian Iñigo De Leon Alvarez on 6/7/20.
//  Copyright © 2020 Christian Iñigo De Leon Alvarez. All rights reserved.
//

import UIKit

enum AuthState {
    case login
    case signup
}

class ViewController: UIViewController, ContainerProtocol {

    @IBOutlet weak var containerView: UIView!
    
    var loginViewController: LoginViewController?
    
    var signupViewController: SignupViewController?
    
    var model = "" {
        willSet {
            print("🍆 changed from \(model) to \(newValue)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureLoginScreen()
        configureSignupScreen()
        switchTo(type: .login)
    }

    private func configureLoginScreen() {
        // You can probably get away with having this in the variable declaration, but the caveat
        // is that if you plan on having closures that will be called by the loginviewcontroller on view did load,
        // it will not work.
        
        loginViewController = R.storyboard.login().instantiateInitialViewController() as? LoginViewController
        
        loginViewController?.wantsToGoToSignupScreen = { [weak self] in
            self?.switchTo(type: .signup)
        }
        loginViewController?.wantsToChangeModel = { [weak self] text in
            self?.model = text
        }
    }
    
    private func configureSignupScreen() {
        signupViewController = R.storyboard.signup().instantiateInitialViewController() as? SignupViewController
        signupViewController?.wantsToGoToLoginScreen = { [weak self] in
            self?.switchTo(type: .login)
        }
        signupViewController?.wantsToChangeModel = { [weak self] text in
            self?.model = text
        }
    }
    
    /// Give me nuggets just means it uses the more complicated code below the guard condition for a pretty animation thing.
    private func switchTo(type: AuthState, giveMeNuggets: Bool = true) {
        
        guard let viewControllerToAdd = type == .login ? loginViewController : signupViewController,
            let viewControllerToRemove = type == .login ? signupViewController : loginViewController else {
                assertionFailure("View controller configuration error!")
                return
        }
        
        guard giveMeNuggets else {
            switchChildControllers(from: viewControllerToRemove,
                                   to: viewControllerToAdd)
            return
        }
        
        
        // Removes old child
        viewControllerToRemove.willMove(toParent: nil)
        
        // Sets the child view's bounds so that it's the same as the container view's bounds. You can also use snapkit for this or some other shit.
        viewControllerToAdd.view.autoresizingMask = [.flexibleWidth,
                                                     .flexibleHeight]
        
        // Try uncommenting this code block and see what happens
        var rect = containerView.bounds
        // Origin change for animation. See ContainerProtocol extension for the simpler transition implementation.
        rect.origin.x = type == .login ? 0 : rect.size.width
        //
        viewControllerToAdd.view.frame = rect
        //
        
        addChild(viewControllerToAdd)
        
        // Animated transition
        if type == .login {
            containerView.insertSubview(viewControllerToAdd.view, belowSubview: viewControllerToRemove.view)
        } else {
            containerView.addSubview(viewControllerToAdd.view)
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut,
                       animations: {
                        if type == .login {
                            rect.origin.x = rect.size.width
                            viewControllerToRemove.view.frame = rect
                        } else {
                            rect.origin.x = 0
                            viewControllerToAdd.view.frame = rect
                        }},
                       completion: { (_) in
                        viewControllerToRemove.view.removeFromSuperview()
                        viewControllerToRemove.removeFromParent()
                        viewControllerToAdd.didMove(toParent: self
                        )})
    }
}
