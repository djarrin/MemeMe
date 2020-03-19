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
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        //Show Tab bar in this view
        tabBarController?.tabBar.isHidden = false
        
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeShowViewController = storyboard!.instantiateViewController(identifier: "MemeShowViewController") as! MemeShowViewController
        memeShowViewController.memeImage = memes[(indexPath as NSIndexPath).row].memedImage
        navigationController!.pushViewController(memeShowViewController, animated: true)
    }
}
