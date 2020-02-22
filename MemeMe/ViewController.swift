//
//  ViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 2/21/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let labelDelegate = memeLabelDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  2.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Move top and bottom toolbars into the safe area
        self.topToolbar.translatesAutoresizingMaskIntoConstraints = false
        self.bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.topToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.topToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.topToolbar.heightAnchor.constraint(equalToConstant: 50),
            self.bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.bottomToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.bottomToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.bottomToolbar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.topTextField.delegate = labelDelegate
        self.bottomTextField.delegate = labelDelegate
        
        // Top and Bottom Textfield attributes
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = .center
        self.bottomTextField.textAlignment = .center
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation)
    }


}

