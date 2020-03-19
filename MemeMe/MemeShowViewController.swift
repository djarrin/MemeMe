//
//  MemeShowViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 3/16/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class MemeShowViewController: UIViewController {
    
    var memeImage: UIImage!
    
    @IBOutlet weak var MemeImageView: UIImageView!
    
    override func viewDidLoad() {
        //Hide Tab bar in this view
        tabBarController?.tabBar.isHidden = true
        
        MemeImageView.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MemeImageView!.image = memeImage
    }
}
