//
//  CollectionViewController+Utils.swift
//  MemeMe
//
//  Created by David Jarrin on 3/18/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

extension CollectionViewController {
    @objc func takeMeme(){
        let memeController = self.storyboard!.instantiateViewController(identifier: "createMemeView") as! CreateMemeViewController
        navigationController!.pushViewController(memeController, animated: true)
    }
    
    func setNavigation() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(takeMeme), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.title = "Sent Memes"
    }
    
    func getDiminsion() -> CGFloat {
        let size = UIScreen.main.bounds.size
        
        if size.width < size.height {
            return (view.frame.size.width - (2 * self.space)) / 3.0
        } else {
            return (view.frame.size.height - (2 * self.space)) / 3.0
        }
    }
}
