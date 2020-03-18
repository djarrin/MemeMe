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
        self.tabBarController?.tabBar.isHidden = true
        
        self.MemeImageView.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.MemeImageView!.image = self.memeImage
    }
}
