//
//  ResultsViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import AVFoundation
import UIKit

class ResultsViewController: UIViewController {

    let congratsLabel = UILabel()
    let finishLabel = UILabel()
    let reviewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = foregroundGreen
        
        congratsLabel.text = "Congratulations!"
        congratsLabel.frame = CGRect(x: 0.0, y: screenHeight/12.0, width: screenWidth, height: screenHeight/12.0)
        congratsLabel.textAlignment = .center
        congratsLabel.textColor = backgroundGray
        congratsLabel.font = UIFont(name: "Inter-Regular", size: 32.0)
        self.view.addSubview(congratsLabel)
        
        finishLabel.text = "You finished the set."
        finishLabel.frame = CGRect(x: 0.0, y: screenHeight/6.0, width: screenWidth, height: screenHeight/12)
        finishLabel.textColor = backgroundGray
        finishLabel.textAlignment = .center
        finishLabel.font = UIFont(name: "Inter-Light", size: 22.0)
        self.view.addSubview(finishLabel)
        
        reviewLabel.text = "Review your mistakes here:"
        reviewLabel.frame = CGRect(x: 0.0, y: screenHeight*3.0/12.0, width: screenWidth, height: screenHeight/12)
        reviewLabel.textColor = backgroundGray
        reviewLabel.textAlignment = .center
        reviewLabel.font = UIFont(name: "Inter-Light", size: 26.0)
        self.view.addSubview(reviewLabel)
        
        let tryButton = UIButton()
        tryButton.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        tryButton.backgroundColor = backgroundGray
        tryButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        // tryButton.layer.borderWidth = 2.0
        let tryLabel = UILabel(frame: tryButton.bounds)
        tryLabel.text = "PROFILE"
        tryLabel.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel.textAlignment = .center
        tryLabel.textColor = foregroundGreen
        tryButton.addSubview(tryLabel)
        
        self.view.addSubview(tryButton)
       
        
    }
    
    @objc func openProfile() {
        let pr = ProfileViewController()
        pr.modalPresentationStyle = .fullScreen
        self.present(pr, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var currY = screenHeight*4.0/12.0 + 20.0
        let margin = 40.0
        let boxSize = screenWidth/2.0 - 60.0
        
        for mistake in mistakes {
            
            let leftBox = UIView(frame: CGRect(x: 40.0, y: currY, width: boxSize, height: boxSize))
            leftBox.backgroundColor = backgroundGray
            let leftShadow = UIView(frame: CGRect(x: 40.0+5.0, y: currY+5.0, width: boxSize, height: boxSize))
            leftShadow.backgroundColor = grayShadow
            self.view.addSubview(leftShadow)
            self.view.addSubview(leftBox)
            
            let rightBox = UIView(frame: CGRect(x: screenWidth/2.0+20.0, y: currY, width: boxSize, height: boxSize))
            rightBox.backgroundColor = backgroundGray
            let rightShadow = UIView(frame: CGRect(x: screenWidth/2.0+25.0, y: currY+5.0, width: boxSize, height: boxSize))
            rightShadow.backgroundColor = grayShadow
            self.view.addSubview(rightShadow)
            
            
            let first = mistake[0]
            let second = mistake[1]
            
            let le = UILabel(frame: leftBox.bounds)
            le.font = UIFont(name: "Inter-Black", size: 24.0)
            le.textAlignment = .center
            le.text = first
            le.textColor = foregroundGreen
            leftBox.addSubview(le)
            
            let ri = UILabel(frame: leftBox.bounds)
            ri.font = UIFont(name: "Inter-Black", size: 24.0)
            ri.textAlignment = .center
            ri.text = second
            ri.textColor = foregroundGreen
            // rightBox.addSubview(ri)
            
            if let videoURL = Bundle.main.url(forResource: mistake[0], withExtension: "MOV") {
                // we found the file in our bundle!
                // let videoURL = URL(fileURLWithPath: "a.MOV")
                // print(videoURL)
                let player = AVPlayer(url: videoURL)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.videoGravity = .resize
                playerLayer.frame = rightBox.bounds
                rightBox.layer.addSublayer(playerLayer)
                player.play()
                player.isMuted = true
                self.view.addSubview(rightBox)
            }
            

            currY += boxSize + 20.0
            
        }
    }

}
