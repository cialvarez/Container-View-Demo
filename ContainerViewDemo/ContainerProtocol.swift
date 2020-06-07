//
//  ContainerProtocol.swift
//  ContainerViewDemo
//
//  Created by Christian Iñigo De Leon Alvarez on 6/7/20.
//  Copyright © 2020 Christian Iñigo De Leon Alvarez. All rights reserved.
//

import UIKit

protocol ContainerProtocol: UIViewController {
    var containerView: UIView! { get set }
}

extension ContainerProtocol {
    func switchChildControllers(from originViewController: UIViewController,
                                to destinationViewController: UIViewController) {
        originViewController.willMove(toParent: nil)
        
        // Sets the child view's bounds so that it's the same as the container view's bounds. You can also use snapkit for this or some other shit.Try uncommenting this code block and see what happens
        destinationViewController.view.autoresizingMask = [.flexibleWidth,
                                                           .flexibleHeight]
        destinationViewController.view.frame = containerView.bounds
        //
        
        addChild(destinationViewController)
        containerView.addSubview(destinationViewController.view)
        destinationViewController.didMove(toParent: self)
        
        originViewController.view.removeFromSuperview()
        originViewController.removeFromParent()
    }
}
