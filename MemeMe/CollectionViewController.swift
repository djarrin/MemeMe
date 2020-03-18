//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by David Jarrin on 3/16/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    let space:CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        //Show Tab bar in this view
        self.tabBarController?.tabBar.isHidden = false
        
        let dimension = self.getDiminsion()

        flowLayout.minimumInteritemSpacing = self.space
        flowLayout.minimumLineSpacing = self.space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView!.reloadData()
    }
    
    func getDiminsion() -> CGFloat {
        let size = UIScreen.main.bounds.size
        
        if size.width < size.height {
            return (view.frame.size.width - (2 * self.space)) / 3.0
        } else {
            return (view.frame.size.height - (2 * self.space)) / 3.0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeCellImage.image = meme.memedImage
        cell.memeCellImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeShowViewController = self.storyboard!.instantiateViewController(identifier: "MemeShowViewController") as! MemeShowViewController
        memeShowViewController.memeImage = self.memes[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(memeShowViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = self.getDiminsion()
        
        return CGSize(width: dimension, height: dimension)
    }
    
    @objc func takeMeme(){
        let memeController = self.storyboard!.instantiateViewController(identifier: "createMemeView") as! ViewController
        self.navigationController!.pushViewController(memeController, animated: true)
    }
    
    func setNavigation() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(takeMeme), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.title = "Sent Memes"
    }
}
