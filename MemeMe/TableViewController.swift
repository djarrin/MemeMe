//
//  RootViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 3/14/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    override func viewDidLoad() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(takeMeme), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.title = "Sent Memes"
    }
    
    @objc func takeMeme(){
        let memeController = self.storyboard!.instantiateViewController(identifier: "createMemeView") as! ViewController
//        if let navController = self.navigationController{
//            navController.present(memeController, animated: true)
//        }
        self.navigationController!.pushViewController(memeController, animated: true)
    }
}
