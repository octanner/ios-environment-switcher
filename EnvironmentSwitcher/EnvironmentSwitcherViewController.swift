//
//  EnvironmentSwitcherViewController.swift
//  EnvironmentSwitcher
//
//  Created by Ben Norris on 2/12/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

import UIKit

public protocol EnvironmentSwitcherDelegate {
    func save(environment: Environment)
    func cancelSwitcher()
}

public class EnvironmentSwitcherViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var delegate: EnvironmentSwitcherDelegate?
    public var appEnvironment: EnvironmentRepresentable?

    
    // MARK: - Internal properties
    
    @IBOutlet weak var pathField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    
    // MARK: - Lifecycle overrides
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appEnvironment = appEnvironment else { fatalError("Must have app environment") }
        if let index = appEnvironment.allEnvironments.indexOf(appEnvironment.currentEnvironment) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    
    // MARK: - Internal functions
    
    @IBAction func saveSwitch(sender: AnyObject) {
        saveUpdatedEnvironment()
    }
    
    @IBAction func cancelSwitch(sender: AnyObject) {
        delegate?.cancelSwitcher()
    }
    
}


// MARK: - Text field delegate

extension EnvironmentSwitcherViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveUpdatedEnvironment()
        return true
    }
    
}


// MARK: - Picker delegate

extension EnvironmentSwitcherViewController: UIPickerViewDelegate {
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let appEnvironment = appEnvironment else { return nil }
        let environment = appEnvironment.allEnvironments[row]
        return environment.name
    }
    
}


// MARK: - Picker data source

extension EnvironmentSwitcherViewController: UIPickerViewDataSource {
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let appEnvironment = appEnvironment else { return 0 }
        return appEnvironment.allEnvironments.count
    }
    
}


// MARK: - Private functions

private extension EnvironmentSwitcherViewController {
    
    func saveUpdatedEnvironment() {
        let updatedEnvironment = Environment(name: "Staging", path: nil)
        delegate?.save(updatedEnvironment)
    }
    
}
