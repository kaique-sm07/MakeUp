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
import AlamofireImage

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
    
    //initial array with youtube video IDs
    let urlArray = ["B8d9FYuZglQ", "4hetO5zQINc", "a5rLN7mikmg", "Jq8b1u0vTRI", "R3qGjuDFOXk", "a4Ov8qvZ2_w", "07j29VphfRQ", "VEZuACLfmIY", "VKqwQnkzvTI"]
    
    var thumbnailImages: [ThumbnailStruct] = []
    
    let videoController  = AVPlayerViewController()
    
    var selectedItem:Int?
    
    //time remaining on video
    var timeObserver: AnyObject!
    var timeRemainingLabel: UILabel = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.thumbnailImages = []
        
        for id in self.urlArray {
            self.getThumbnailImage(id)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //populate the player thumbnail image with the first image on the playlist
        if self.thumbnailImages.count > 0 {
            self.playerThumbnailImageView.image = self.thumbnailImages[self.selectedItem!].image
        }
        
        self.playVideo()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //pause the video
        self.pauseVideo()
    }
    
    //function to get a youtube thumbnail image from the video ID
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
        
        //set the selectedItem to 0 the first time
        self.selectedItem = 0
        
        //Notification that is sent when video ends
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.itemDidFinishPlaying), name: AVPlayerItemDidPlayToEndTimeNotification, object: self.videoController.player?.currentItem)
        
        //HCYouTubeParser Test Project
        let youTubeString : String = self.urlPrefix + self.urlArray[self.selectedItem!]
        let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
        let urlString : String = videos["hd720"] as! String
        
        //AVPlayer
        self.addVideoPlayer()
        self.videoController.player?.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: urlString)!))
        self.videoController.showsPlaybackControls = true
        self.playerView.bringSubviewToFront(self.videoController.view)
        
        //time observer
        let timeInterval: CMTime = CMTimeMakeWithSeconds(1.0, 10)
        timeObserver = self.videoController.player?.addPeriodicTimeObserverForInterval(timeInterval, queue: dispatch_get_main_queue()) { (elapsedTime: CMTime) -> Void in
            
//            print("elapsedTime now %f\(CMTimeGetSeconds(elapsedTime))")
            self.observeTime(elapsedTime)
        }
        
        self.timeRemainingLabel.textColor = UIColor.whiteColor()
        self.videoController.view.addSubview(self.timeRemainingLabel)
    }
    
    override func viewWillLayoutSubviews() {
        let controlsHeight: CGFloat = 50
        let controlsY: CGFloat = self.playerView.bounds.size.height - controlsHeight
        self.timeRemainingLabel.frame = CGRect(x: 5, y: controlsY, width: 60, height: controlsHeight)
    }
    
    deinit {
        self.videoController.player?.removeTimeObserver(timeObserver)
    }
    
    
    private func updateTimeLabel(elapsedTime: Float64, duration: Float64) {
        let timeRemaining: Float64 = CMTimeGetSeconds((self.videoController.player?.currentItem?.duration)!) - elapsedTime
        self.timeRemainingLabel.text = String("%02d:%02d", ((lround(timeRemaining) / 60) % 60), lround(timeRemaining) % 60)
    }
    
    private func observeTime(elapsedTime: CMTime) {
        let duration = CMTimeGetSeconds(elapsedTime)
        if (isfinite(duration)) {
            let elapsedTime = CMTimeGetSeconds(elapsedTime)
            self.updateTimeLabel(elapsedTime, duration: duration)
        }
    }
    
    //method called when video ends
    func itemDidFinishPlaying() {
        //play the next video on the playlist
        if (self.selectedItem! + 1) < self.thumbnailImages.count {
            
            self.selectedItem = self.selectedItem! + 1
            let youTubeString : String = self.urlPrefix + (self.thumbnailImages[self.selectedItem!].id)
            let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
            let urlString : String = videos["hd720"] as! String
            
            self.videoController.player?.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: urlString)!))
            self.playVideo()
        }
    }
    
//    func addLabel() {
//        let label = UILabel(frame: CGRectMake(50.0, 20.0, 320.0, 30.0))
//        label.text = "My Awesome video"
//        
//        self.playerView.addSubview(label)
//    }
    
    func addVideoPlayer() {
        
//        let url = NSURL(string: url)
        
        self.videoController.view.frame = self.playerView.bounds
        self.videoController.showsPlaybackControls = false
        
        // Possible Options:
        // AVLayerVideoGravityResize (default)
        // AVLayerVideoGravityResizeAspect
        // AVLayerVideoGravityResizeAspectFill
        self.videoController.videoGravity = AVLayerVideoGravityResizeAspect
        
        
        videoController.player = AVPlayer()
        self.playerView.addSubview(self.videoController.view)
    }
    
    func playVideo() {
        self.videoController.player?.play()
    }
    
    func pauseVideo() {
        self.videoController.player?.pause()
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
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        //update selectedItem
        self.selectedItem = indexPath.row
        
        let youTubeString : String = self.urlPrefix + (self.thumbnailImages[self.selectedItem!].id)
        let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
        let urlString : String = videos["hd720"] as! String
        
        self.videoController.player?.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: NSURL(string: urlString)!))
        self.playVideo()
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