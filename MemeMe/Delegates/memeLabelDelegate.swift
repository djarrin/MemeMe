//
//  memeLabelDelegate.swift
//  MemeMe
//
//  Created by David Jarrin on 2/22/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation
import UIKit

class memeLabelDelegate : NSObject, UITextFieldDelegate {

    var activeTextField: Bool
    
    override init() {
        self.activeTextField = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = true
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = false
        print(textField)
    }
}
