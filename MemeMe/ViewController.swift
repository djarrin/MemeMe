//
//  ViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 2/21/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var takePhotoButton: UIBarButtonItem!
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let labelDelegate = memeLabelDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // some logic to unfocus the text fields
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
        // Enable or disable the takePhotoButton depending on if camera is available
        self.takePhotoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // disable the share button unless an image is present
//        if self.memeView.image == nil {
//            self.shareButton.isEnabled = false
//        }
        
        // Move top toolbar into the safe area and adjust height so as fill in the top
//        self.topToolbar.translatesAutoresizingMaskIntoConstraints = false
//        self.bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.topToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            self.topToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            self.topToolbar.heightAnchor.constraint(equalToConstant: 80),
//            self.bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            self.bottomToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            self.bottomToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            self.bottomToolbar.heightAnchor.constraint(equalToConstant: 50)
//        ])
        
//        self.topTextField.delegate = labelDelegate
//        self.bottomTextField.delegate = labelDelegate
        
        // Top and Bottom Textfield attributes
//        self.topTextField.defaultTextAttributes = memeTextAttributes
//        self.bottomTextField.defaultTextAttributes = memeTextAttributes
//        self.topTextField.textAlignment = .center
//        self.bottomTextField.textAlignment = .center
        
        // set up the memeView properties
//        self.memeView.contentMode = .scaleAspectFill
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if self.bottomTextField.isEditing {
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let photoPickerController = UIImagePickerController()
        photoPickerController.delegate = self
        photoPickerController.sourceType = .camera
        present(photoPickerController, animated: true, completion: nil)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        let photoPickerController = UIImagePickerController()
        photoPickerController.delegate = self
        photoPickerController.sourceType = .photoLibrary
        present(photoPickerController, animated: true, completion: nil)
    }
    
    @IBAction func resetMeme() {
        self.bottomTextField.text = "BOTTOM TEXT"
        self.topTextField.text = "TOP TEXT"
        self.memeView.image = nil
        self.shareButton.isEnabled = false
    }
    
    @IBAction func share(_ sender: Any) {
        let memeImage = generateMemeImage()
        if let originalImage = memeView.image {
            let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: originalImage, memedImage: memeImage)
            let shareMeme = [meme.memedImage]
            let activityViewController = UIActivityViewController(activityItems: shareMeme, applicationActivities: nil)
            activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    // User canceled
                    return
                }
                UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
            }
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.memeView.image = image
            self.shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemeImage() -> UIImage {
        
        // Hide toolbar and navbar
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.topToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
        self.topTextField.tintColor = UIColor.clear
        self.bottomTextField.tintColor = UIColor.clear

        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // re-show toolbar and navbar
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.topToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
        self.topTextField.tintColor = UIColor.blue
        self.bottomTextField.tintColor = UIColor.blue
        
        return memedImage
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
}

