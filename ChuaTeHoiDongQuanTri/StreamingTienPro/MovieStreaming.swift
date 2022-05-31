//
//  MovieStreaming.swift
//  StreamingTienPro
//
//  Created by Valerian on 01/03/2022.
//

import Foundation
import AVKit
import AVFoundation

public class MovieStreaming {
    
    private let playVideoViewController: AVPlayerViewController = {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = true
        controller.showsTimecodes = true
        return controller
    }()
    
    private lazy var activityIndicatorView : UIActivityIndicatorView = {
           let loading = UIActivityIndicatorView()
           loading.hidesWhenStopped = true
           loading.style = .large
           loading.color = .white
           return loading
       }()
    
    private lazy var playerView: UIView = {
        let view = playVideoViewController.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avPlayer = AVPlayer()
    
    public init() { }
    
    //MARK: - Public Interface
    
    public func configure(in view : UIView) {
        view.addSubview(playerView)
        playerView.addSubview(activityIndicatorView)
          NSLayoutConstraint.activate([
            self.playerView.topAnchor.constraint(equalTo: view.topAnchor),
            self.playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: playerView.centerYAnchor),

          ])
          activityIndicatorView.startAnimating()
    }
    
    public func streaming(with movieURL : URL, subRemote : String) {
        let asset = AVAsset(url: movieURL)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)
        
        if subRemote != "" {
            addSubIfNeeded(subRemote: subRemote)
        }
        if subRemote == "okokok" {
            playVideoViewController.showsPlaybackControls = false
        }
        self.playVideoViewController.player = avPlayer
        self.playVideoViewController.player?.play()
        self.activityIndicatorView.stopAnimating()
    }
    
    public func streamingShortVideo(with movieURL : URL) {
        let asset = AVAsset(url: movieURL)
        let playerItem = AVPlayerItem(asset: asset)
        self.avPlayer.replaceCurrentItem(with: playerItem)
        self.playVideoViewController.player = avPlayer
        self.playVideoViewController.showsPlaybackControls = false
        self.playVideoViewController.player?.play()
        self.activityIndicatorView.stopAnimating()
    }
        
    public func pause() {
        self.avPlayer.pause()
    }
    
    private func addSubIfNeeded(subRemote : String) {
        let subtitleRemoteUrl = URL(string: subRemote)
        if let repsoneSub = subtitleRemoteUrl {
            self.playVideoViewController.addSubtitles()
            self.playVideoViewController.open(fileFromRemote: repsoneSub)
            self.playVideoViewController.subtitleLabel?.textColor = UIColor.white
        }
    }
}


