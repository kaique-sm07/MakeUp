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

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerView: UIView!
    
    let videoController  = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //HCYouTubeParser Test Project
        let youTubeString : String = "https://www.youtube.com/watch?v=wWy89ey6tyw"
        let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
        print(videos)
        let urlString : String = videos["hd720"] as! String
//        let asset = AVAsset(URL: NSURL(string: urlString)!)
        
        //AVPlayer
        // add video player
        self.addVideoPlayer(urlString)
        // add label
        self.addLabel()
        // play video
        //self.playVideo()
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
//        return images.count
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("inspirationCell", forIndexPath: indexPath) as! InspirationCellCollectionViewCell
//        cell.backgroundColor = UIColor.blackColor()
//        print(self.images)
//        cell.imagePost.image = self.images[indexPath.row]
        
//        return cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlaylistCell", forIndexPath: indexPath)
        return cell
    }
}