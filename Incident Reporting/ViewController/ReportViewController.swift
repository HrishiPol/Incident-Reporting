//
//  ReportViewController.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import UIKit
import MaterialComponents

/// Class to report incident.
class ReportViewController: UIViewController {
    
    /// Machine name textfield.
    @IBOutlet weak var machineNameTextField: MDCFilledTextField!
    
    /// Location textField.
    @IBOutlet weak var locationTextField: MDCFilledTextField!
    
    /// Description textfield.
    @IBOutlet weak var descriptionTextField: MDCFilledTextField!
    
    /// Incident view model.
    var incidentViewModel: IncidentViewModel?
    
    /// Closure to validate report entries.
    var validateCompletionClosure: IncidentValidateCompletionClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.kReportIncidentTitle.rawValue
        
        // Submit button.
        let rightBarButtonItem = UIBarButtonItem.init(title: Constant.kSubmitButtonTitle.rawValue,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(submitButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        // Tap Gesture to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer.init(target: self,
                                                     action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        // Closure to validate report entries.
        validateCompletionClosure = { [unowned self] ( status: IncidentStatus) -> Void in
            switch status {
            case .valid:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            case .invalid:
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    /// Function to get current timestamp in string
    /// - Returns: Timestamp in string.
    private func currentTimeStamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.kTimeStamp.rawValue
        let now = dateFormatter.string(from: Date())
        return now
    }
    
    /// Method invoked in submit button pressed.
    @objc func submitButtonPressed() {
        if let name = machineNameTextField.text,
            let location = locationTextField.text,
            let description = descriptionTextField.text {
            incidentViewModel?.submit(name, location, description, currentTimeStamp(), completionHandler: {_ in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    /// Method to dismiss keyboard.
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate methods.
extension ReportViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = machineNameTextField.text,
            let location = locationTextField.text,
            let description = descriptionTextField.text {
            incidentViewModel = IncidentViewModel.init()
            if let handler = validateCompletionClosure {
                incidentViewModel?.validate(name, location, description, completionHanlder: handler)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
