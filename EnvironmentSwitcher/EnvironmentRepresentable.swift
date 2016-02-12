//
//  EnvironmentRepresentable.swift
//  EnvironmentSwitcher
//
//  Created by Ben Norris on 2/12/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

import Foundation

public protocol EnvironmentRepresentable {
    typealias Environment: RawRepresentable
    var currentEnvironment: Environment { get set }
    var allEnvironments: [Environment] { get }
    var customPath: String? { get set }
}
