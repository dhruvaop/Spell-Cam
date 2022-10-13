//
//  ViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let welcomeLabel = UILabel()
    let goButton = UIButton()
    let tapLabel = UILabel()
    
    let imageRender = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("App started!")
        
        // welcomeLabel.text = "WELCOME"
        welcomeLabel.textAlignment = .center
        welcomeLabel.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight/4.0)
        welcomeLabel.textColor = foregroundGreen
        welcomeLabel.font = UIFont(name: "Inter-Black", size: 32.0)
        self.view.addSubview(welcomeLabel)
        
        self.view.backgroundColor = backgroundGray
        
        imageRender.frame = CGRect(x: 40.0, y: screenHeight/2 - 100.0, width: screenWidth-80.0, height: 200.0)
        imageRender.image = UIImage(named: "introwork")
        imageRender.contentMode = .scaleAspectFit
        self.view.addSubview(imageRender)
        
        tapLabel.text = "TAP ANYWHERE TO BEGIN"
        tapLabel.font = UIFont(name: "Inter-Light", size: 14.0)
        tapLabel.textAlignment = .center
        tapLabel.textColor = foregroundGreen
        tapLabel.frame = CGRect(x: 0.0, y: screenHeight*5/6.0, width: screenWidth, height: screenHeight/6.0)
        self.view.addSubview(tapLabel)
        
        goButton.frame = UIScreen.main.bounds
        goButton.addTarget(self, action: #selector(startProcess), for: .touchUpInside)
        self.view.addSubview(goButton)
        
    }
    
    @objc func startProcess() {
    
        availableSets.append(FlashcardSet(withName: "Introduction", withDifficulty: "Easy", withWords:
            ["yo", "hi"]
        ))
        availableSets.append(FlashcardSet(withName: "Going deeper", withDifficulty: "Medium", withWords:
            ["hi", "bye", "grand", "inter"]
        ))
        availableSets.append(FlashcardSet(withName: "Extensions", withDifficulty: "Hard", withWords:
            ["hi", "bye", "trek", "hike", "why", "am", "filter"]
        ))
        availableSets.append(FlashcardSet(withName: "Advanced Skills", withDifficulty: "Insane", withWords:
            ["hi", "bye", "foundation", "exquisite", "aperture", "craving", "plot", "sing", "dance"]
        ))
        
        let gr = ChooseViewController()
        gr.modalPresentationStyle = .fullScreen
        present(gr, animated: true, completion: nil)
        
    }


}

