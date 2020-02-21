//
//  InteractionTableCellView.swift
//  TableviewAsynchronousUpdate
//
//  Created by Bharatraj Rai on 2/16/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Cocoa

class InteractionTableCellView: NSTableCellView {

    @IBOutlet weak var subjectTextField: NSTextField!
    @IBOutlet weak var fromAddressTextField: NSTextField!
    @IBOutlet weak var toAddressTextField: NSTextField!
    @IBOutlet weak var mlNrnPercentageTextField: NSTextField!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    /// Below method has been defined to assign the model values to the UI object.
    
    func configureViewModel(emailModel: EmailModel) {
        subjectTextField.stringValue = emailModel.subject ?? Constants.placeholderValue
        fromAddressTextField.stringValue = emailModel.fromAddress ?? Constants.placeholderValue
        toAddressTextField.stringValue = emailModel.toAddress ?? Constants.placeholderValue
        mlNrnPercentageTextField.doubleValue = emailModel.mlNrnPercentage ?? 0
        progressIndicator.isHidden = (emailModel.isMlypeScoreDataLoaded ?? false)
        progressIndicator.startAnimation(!(emailModel.isMlypeScoreDataLoaded ?? false))
        addAccessibiltyText(modelData: emailModel)
    }
    
    func addAccessibiltyText(modelData: EmailModel) {
        subjectTextField.setAccessibilityLabel(modelData.subject)
        fromAddressTextField.setAccessibilityLabel(modelData.fromAddress)
        toAddressTextField.setAccessibilityLabel(modelData.toAddress)
    }
}
