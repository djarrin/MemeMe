//
//  ViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 2/21/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var takePhotoButton: UIBarButtonItem!
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let labelDelegate = MemeLabelDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.strokeWidth: -2.0,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Tab bar in this view
        tabBarController?.tabBar.isHidden = true
        
        // some logic to unfocus the text fields
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
        
        // Enable or disable the takePhotoButton depending on if camera is available
        takePhotoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // disable the share button unless an image is present
        if memeView.image == nil {
            shareButton.isEnabled = false
        }
        
        topTextField.delegate = labelDelegate
        bottomTextField.delegate = labelDelegate
        
        // Top and Bottom Textfield attributes
        setUpTextField(textField: topTextField, attributes: memeTextAttributes, "TOP TEXT")
        setUpTextField(textField: bottomTextField, attributes: memeTextAttributes, "BOTTOM TEXT")
        
        // set up the memeView properties
        memeView.contentMode = .scaleAspectFit
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        selectPhoto(sourceType: .camera)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        selectPhoto(sourceType: .photoLibrary)
    }
    
    @IBAction func returnToHistory() {
        tabBarController?.tabBar.isHidden = false
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func share(_ sender: Any) {
        let memeImage = generateMemeImage()
        if let originalImage = memeView.image {
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImage, memedImage: memeImage)
            let shareMeme = [meme.memedImage]
            let activityViewController = UIActivityViewController(activityItems: shareMeme, applicationActivities: nil)
            activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    // User canceled
                    return
                }
                self.saveMeme(meme: meme)
            }
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func saveMeme(meme: Meme) {
        //save to album
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
        
        // add meme to memes array
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        returnToHistory()
    }
    
    func setUpTextField(textField: UITextField, attributes: [NSAttributedString.Key: Any] , _ text: String) {
        textField.defaultTextAttributes = attributes
        textField.textAlignment = .center
        textField.text = text
    }
    
    func selectPhoto(sourceType: UIImagePickerController.SourceType){
        let photoPickerController = UIImagePickerController()
        photoPickerController.delegate = self
        photoPickerController.sourceType = sourceType
        present(photoPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            memeView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemeImage() -> UIImage {
        
        // Hide toolbar and navbar
        hideToolbars(true)

        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // re-show toolbar and navbar
        hideToolbars(false)
        
        return memedImage
    }
    
    func hideToolbars(_ hide: Bool) {
        navigationController?.setNavigationBarHidden(hide, animated: false)
        navigationController?.isNavigationBarHidden = hide
        bottomToolbar.isHidden = hide
        
        if hide {
            topTextField.tintColor = UIColor.clear
            bottomTextField.tintColor = UIColor.clear
        } else {
            topTextField.tintColor = UIColor.blue
            bottomTextField.tintColor = UIColor.blue
        }
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
}

