//
//  AuthModule.swift
//  ContainerViewDemo
//
//  Created by Christian Iñigo De Leon Alvarez on 6/7/20.
//  Copyright © 2020 Christian Iñigo De Leon Alvarez. All rights reserved.
//

import Foundation

protocol AuthModule {
    var wantsToChangeModel: ((_ text: String) -> Void)? { get set }
}
