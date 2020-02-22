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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
