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
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        //Show Tab bar in this view
        tabBarController?.tabBar.isHidden = false
        
        let dimension = self.getDiminsion()

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeCellImage.image = meme.memedImage
        cell.memeCellImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeShowViewController = storyboard!.instantiateViewController(identifier: "MemeShowViewController") as! MemeShowViewController
        memeShowViewController.memeImage = memes[(indexPath as NSIndexPath).row].memedImage
        navigationController!.pushViewController(memeShowViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = getDiminsion()
        
        return CGSize(width: dimension, height: dimension)
    }
}
