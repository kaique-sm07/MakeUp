//
//  SecondViewController.swift
//  PocPinterest
//
//  Created by Kaique de Souza Monteiro on 03/06/16.
//  Copyright © 2016 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import Alamofire

struct ThumbnailStruct {
    let id:String
    let image:UIImage
}

class SecondViewController: UIViewController {

    @IBOutlet weak var playerThumbnailImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerView: UIView!
    
    let urlPrefix = "https://www.youtube.com/watch?v="
    let imgUrlPrefix = "https://img.youtube.com/vi/"
    let imgUrlSufix = "/hqdefault.jpg"
    
    let urlArray = ["B8d9FYuZglQ", "4hetO5zQINc", "a5rLN7mikmg", "Jq8b1u0vTRI", "R3qGjuDFOXk", "a4Ov8qvZ2_w", "07j29VphfRQ", "VEZuACLfmIY", "di5dk491IS4", "VKqwQnkzvTI"]
    
    var thumbnailImages: [ThumbnailStruct] = []
    
    let videoController  = AVPlayerViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.thumbnailImages = []
        
        for id in self.urlArray {
            self.getThumbnailImage(id)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.thumbnailImages.count > 0 {
            self.playerThumbnailImageView.image = self.thumbnailImages.first!.image
        }
    }
    
    func getThumbnailImage(ID: String) {
        Alamofire.request(.GET, imgUrlPrefix + ID + imgUrlSufix)
            .responseImage { response in
                if let image = response.result.value {
                    self.thumbnailImages.append(ThumbnailStruct(id: ID, image: image))
                    self.collectionView.reloadData()
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //HCYouTubeParser Test Project
        let youTubeString : String = self.urlPrefix + self.urlArray.first!
        let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
        print(videos)
        let urlString : String = videos["hd720"] as! String
        
        if self.thumbnailImages.first != nil {
            self.playerThumbnailImageView.image = self.thumbnailImages.first!.image
        }
        
        //AVPlayer
        self.addVideoPlayer(urlString)
        self.playVideo()
    }
    
//    @IBAction func playButtonAction(sender: AnyObject) {
//        self.playVideo()
//        self.playButton.hidden = true
//    }
    
    func addLabel() {
        let label = UILabel(frame: CGRectMake(50.0, 20.0, 320.0, 30.0))
        label.text = "My Awesome video"
        
        self.playerView.addSubview(label)
    }
    
    func addVideoPlayer(url: String) {
        
        let url = NSURL(string: url)
        
        videoController.view.frame = self.playerView.bounds
        videoController.showsPlaybackControls = false
        
        // Possible Options:
        // AVLayerVideoGravityResize (default)
        // AVLayerVideoGravityResizeAspect
        // AVLayerVideoGravityResizeAspectFill
        videoController.videoGravity = AVLayerVideoGravityResizeAspect
        
        
        videoController.player = AVPlayer(URL: url!)
        self.playerView.addSubview(videoController.view)
    }
    
    func playVideo() {
        videoController.player?.play()
    }
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.thumbnailImages.count > 0 {
            return self.thumbnailImages.count
        } else {
            return 1
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlaylistCell", forIndexPath: indexPath) as! TutorialCollectionViewCell
        
        if self.thumbnailImages.count > 0 {
            cell.thumbnailImageView.image = self.thumbnailImages[indexPath.row].image
        } else {
            cell.thumbnailImageView.image = UIImage()
        }
        
        return cell
    }
}