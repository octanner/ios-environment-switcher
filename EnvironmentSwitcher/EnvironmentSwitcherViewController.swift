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
    var environments: [Environment]!
    
    
    // MARK: - Constants
    
    private let customName = "Custom"
    
    
    // MARK: - Lifecycle overrides
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appEnvironment = appEnvironment else { fatalError("Must have app environment") }
        environments = appEnvironment.allEnvironments
        if let index = environments.indexOf(appEnvironment.currentEnvironment) {
            picker.selectRow(index, inComponent: 0, animated: false)
            pathField.text = appEnvironment.currentEnvironment.path
            pathField.enabled = appEnvironment.currentEnvironment.name == customName
        }
    }
    
    
    // MARK: - Internal functions
    
    @IBAction func saveSwitch(sender: AnyObject) {
        view.endEditing(true)
        saveUpdatedEnvironment()
    }
    
    @IBAction func cancelSwitch(sender: AnyObject) {
        delegate?.cancelSwitcher()
    }
    
}


// MARK: - Text field delegate

extension EnvironmentSwitcherViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(textField: UITextField) {
        let index = picker.selectedRowInComponent(0)
        let custom = environments[index]
        if custom.name != customName { return }
        let updatedCustom = Environment(name: customName, path: textField.text)
        environments[index] = updatedCustom
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveUpdatedEnvironment()
        return true
    }
    
}


// MARK: - Picker delegate

extension EnvironmentSwitcherViewController: UIPickerViewDelegate {
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let environment = environments[row]
        return environment.name
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let environment = environments[row]
        pathField.text = environment.path
        pathField.enabled = environment.name == customName
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
        let updatedEnvironment = environments[picker.selectedRowInComponent(0)]
        delegate?.save(updatedEnvironment)
    }
    
}
