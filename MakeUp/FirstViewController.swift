//
//  FirstViewController.swift
//  PocPinterest
//
//  Created by Kaique de Souza Monteiro on 03/06/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class FirstViewController: UIViewController{
    
    @IBOutlet weak var inspirationCollection: UICollectionView!
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.inspirationCollection.reloadData()
    }


}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("inspirationCell", forIndexPath: indexPath) as! InspirationCellCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.imagePost.sd_setImageWithURL(NSURL(string: self.images[indexPath.row]))
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("fullScreenView")
        self.presentViewController(controller!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(controller!, animated: true)
    }

}

