//
//  EnvironmentSwitcherViewController.swift
//  EnvironmentSwitcher
//
//  Created by Ben Norris on 2/12/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

import NetworkStack
import UIKit


public class EnvironmentSwitcherViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var environments = [AppNetworkState]()

    
    // MARK: - Internal properties
    
    @IBOutlet weak var apiURLField: UITextField!
    @IBOutlet weak var tokenURLField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    
    // MARK: - Constants
    
    private let customName = "custom"
    
    
    // MARK: - Lifecycle overrides
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appEnvironment = AppNetworkState.currentAppState else { fatalError("Must have app environment") }

        for (index, environment) in environments.enumerate() {
            if appEnvironment.environmentKey == environment.environmentKey {
                let custom = environment.environmentKey == customName
                picker.selectRow(index, inComponent: 0, animated: false)
                apiURLField.text = environment.apiURLString
                apiURLField.enabled = custom
                tokenURLField.text = environment.tokenEndpointURLString
                tokenURLField.enabled = custom
                break
            }
        }
    }
    
    
    // MARK: - Internal functions
    
    @IBAction func saveSwitch(sender: AnyObject) {
        view.endEditing(true)
        saveUpdatedEnvironment()
    }
    
    @IBAction func cancelSwitch(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


// MARK: - Text field delegate

extension EnvironmentSwitcherViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(textField: UITextField) {
        let index = picker.selectedRowInComponent(0)
        let custom = environments[index]
        if custom.environmentKey != customName { return }
        let updatedCustom = AppNetworkState(apiURLString: apiURLField.text!, tokenEndpointURLString: tokenURLField.text!, environmentKey: customName)
        environments[index] = updatedCustom
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == apiURLField {
            tokenURLField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}


// MARK: - Picker delegate

extension EnvironmentSwitcherViewController: UIPickerViewDelegate {
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let environment = environments[row]
        return environment.environmentKey
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let environment = environments[row]
        let custom = environment.environmentKey == customName
        apiURLField.text = environment.apiURLString
        apiURLField.enabled = custom
        tokenURLField.text = environment.tokenEndpointURLString
        tokenURLField.enabled = custom
    }
    
}


// MARK: - Picker data source

extension EnvironmentSwitcherViewController: UIPickerViewDataSource {
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return environments.count
    }
    
}


// MARK: - Private functions

private extension EnvironmentSwitcherViewController {
    
    func saveUpdatedEnvironment() {
        let updatedEnvironment = environments[picker.selectedRowInComponent(0)]
        AppNetworkState.currentAppState = updatedEnvironment
    }
    
}
