//
//  FirstViewController.swift
//  PocPinterest
//
//  Created by Kaique de Souza Monteiro on 03/06/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class FirstViewController: UIViewController, CategoryTableViewDelegate {
    
    @IBOutlet weak var inspirationCollection: UICollectionView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "https://api.tumblr.com/v2/blog/makeupbeauty.tumblr.com/posts/photo", parameters: ["api_key": "njqwlWI3Z0wSW9foq6l6ca23OYm5xcmX2XqUPaZ8Ct1RsbLa3n"])
            .responseJSON { response in
                if let json = response.result.value {
                                    
                    let bla = JSON(json)
                    for i in 0...19 {
                        Alamofire.request(.GET, bla["response"]["posts"][i]["photos"][0]["original_size"]["url"].string!)
                            .responseImage { response in
                                if let image = response.result.value {
                                    self.images.append(image)
                                    self.inspirationCollection.reloadData()
                                }
                        }
                    }
                    
                }
        }
            }
    
    func changeCategory(images: [String]) {
        print(images)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("inspirationCell", forIndexPath: indexPath) as! InspirationCellCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        //print(self.images)
        cell.imagePost.image = self.images[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("fullScreenView")
        self.presentViewController(controller!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(controller!, animated: true)
    }

}

