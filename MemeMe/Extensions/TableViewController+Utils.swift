//
//  TableViewController+Utils.swift
//  MemeMe
//
//  Created by David Jarrin on 3/18/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

extension TableViewController {
    func setNavigation() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(takeMeme), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.title = "Sent Memes"
    }
    
    @objc func takeMeme(){
        let memeController = self.storyboard!.instantiateViewController(identifier: "createMemeView") as! ViewController
        self.navigationController!.pushViewController(memeController, animated: true)
    }
}
