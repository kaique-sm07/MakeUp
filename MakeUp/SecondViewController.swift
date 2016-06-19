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

class SecondViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playerThumbnailImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerView: UIView!
    
    let urlPrefix = "https://www.youtube.com/watch?v="
    let imgUrlPrefix = "https://img.youtube.com/vi/"
    let imgUrlSufix = "/hqdefault.jpg"
    
    let urlArray = ["8To-6VIJZRE", "v76B8GUYflk", "8To-6VIJZRE", "v76B8GUYflk"]
    
    var thumbnailImages: [UIImage] = [UIImage]()
    
    let videoController  = AVPlayerViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //get thumbnail images
        for string in self.urlArray {
            let youtubeID : String = string
            let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: self.urlPrefix + youtubeID))
            
            let urlString : String = videos["medium"] as! String
            
//            self.thumbnailImages.append(thumbnailImage)
//            self.collectionView.reloadData()
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //HCYouTubeParser Test Project
        let youTubeString : String = "https://www.youtube.com/watch?v=wWy89ey6tyw"
        let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
        print(videos)
        let urlString : String = videos["hd720"] as! String
        
        //AVPlayer
        // add video player
        self.addVideoPlayer(urlString)
        // add label
//        self.addLabel()
        // play video
//        self.playVideo()
        self.playerView.bringSubviewToFront(self.playButton)
    }
    
    @IBAction func playButtonAction(sender: AnyObject) {
        self.playVideo()
        self.playButton.hidden = true
    }
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
            cell.thumbnailImageView.image = self.thumbnailImages[indexPath.row]
        } else {
            cell.thumbnailImageView.image = UIImage()
        }
        
        return cell
    }
}