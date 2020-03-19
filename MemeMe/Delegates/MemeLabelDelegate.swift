//
//  memeLabelDelegate.swift
//  MemeMe
//
//  Created by David Jarrin on 2/22/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import Foundation
import UIKit

class MemeLabelDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
