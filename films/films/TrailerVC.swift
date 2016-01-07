//
//  TrailerVC.swift
//  films
//
//  Created by Dulio Denis on 1/6/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit
import AVKit

class TrailerVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(URL: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }

}
