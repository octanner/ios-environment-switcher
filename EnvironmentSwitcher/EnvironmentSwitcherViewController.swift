//
//  EnvironmentSwitcherViewController.swift
//  EnvironmentSwitcher
//
//  Created by Ben Norris on 2/12/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

import UIKit

public protocol EnvironmentSwitcherDelegate {
    func closeSwitcher()
}

public class EnvironmentSwitcherViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var delegate: EnvironmentSwitcherDelegate?
    public var appEnvironment: EnvironmentRepresentable?

    
    // MARK: - Internal functions
    
    @IBAction func saveSwitch(sender: AnyObject) {
        delegate?.closeSwitcher()
    }
    
    @IBAction func cancelSwitch(sender: AnyObject) {
        delegate?.closeSwitcher()
    }
    
}
