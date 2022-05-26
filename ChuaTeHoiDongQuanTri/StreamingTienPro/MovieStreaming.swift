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
    }
    
    public func streaming(with movieURL : URL, subRemote : String) {
        let asset = AVAsset(url: movieURL)
        let playerItem = AVPlayerItem(asset: asset)
        self.avPlayer.replaceCurrentItem(with: playerItem)
        self.avPlayer.appliesMediaSelectionCriteriaAutomatically = false
        
        for characteristic in asset.availableMediaCharacteristicsWithMediaSelectionOptions {
            print("\(characteristic)")

            // Retrieve the AVMediaSelectionGroup for the specified characteristic.
            if let group = asset.mediaSelectionGroup(forMediaCharacteristic: characteristic) {
                // Print its options.
                for option in group.options {
                    print("  Option: \(option.displayName)")
                }
            }
        }
        
        if subRemote != "" {
            addSubIfNeeded(subRemote: subRemote)
        }
        self.playVideoViewController.player = avPlayer
    }
    
    public func play() {
        self.playVideoViewController.player?.play()
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


