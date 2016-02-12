//
//  EnvironmentRepresentable.swift
//  EnvironmentSwitcher
//
//  Created by Ben Norris on 2/12/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

import Foundation

public struct Environment {
    public let name: String
    public let path: String?
    public init(name: String, path: String?) {
        self.name = name
        self.path = path
    }
}

public protocol EnvironmentRepresentable {
    var currentEnvironment: Environment { get }
    var allEnvironments: [Environment] { get }
}
