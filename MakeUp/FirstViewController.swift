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

class FirstViewController: UIViewController {

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
                                    print("image downloaded: \(image)")
                                }
                        }
                    }
                    
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as CollectionViewCell
//        cell.backgroundColor = UIColor.blackColor()
//        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
//        cell.imageVie
//    }
//}

