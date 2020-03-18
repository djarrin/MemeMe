//
//  RootViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 3/14/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var memes: [Meme]!
    
    override func viewDidLoad() {
        self.setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        //Show Tab bar in this view
        self.tabBarController?.tabBar.isHidden = false
        
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeShowViewController = self.storyboard!.instantiateViewController(identifier: "MemeShowViewController") as! MemeShowViewController
        memeShowViewController.memeImage = self.memes[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(memeShowViewController, animated: true)
    }
    
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
