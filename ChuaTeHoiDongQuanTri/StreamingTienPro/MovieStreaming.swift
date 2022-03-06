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
    
    private let playVideoViewController = AVPlayerViewController()
    
    private let avPlayer = AVPlayer()
    
    private lazy var playerView : UIView = {
        let view = playVideoViewController.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init() { }
    
    //MARK: - Public Interface
    
    public func configure(in view : UIView) {
        view.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    public func streaming(with movieURL : URL, subRemote : String) {
        let asset = AVAsset(url: movieURL)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)
        
        if subRemote != "" {
            addSubIfNeeded(subRemote: subRemote)
        }
        
        playVideoViewController.player = avPlayer
        playVideoViewController.player?.play()
    }
    
    public func pause() {
        avPlayer.pause()
    }
    
    private func addSubIfNeeded(subRemote : String) {
        let subtitleRemoteUrl = URL(string: subRemote)
        if let repsoneSub = subtitleRemoteUrl {
            playVideoViewController.addSubtitles()
            playVideoViewController.open(fileFromRemote: repsoneSub)
            playVideoViewController.subtitleLabel?.textColor = UIColor.white
        }
    }
}


