//
//  ProfileViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = foregroundGreen
        
        let imageView = UIImageView(frame: CGRect(x: screenWidth/2-60.0, y: 100.0, width: 120.0, height: 120.0))
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 60.0
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = backgroundGray.cgColor
        self.view.addSubview(imageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 0.0, y: 220.0, width: screenWidth, height: 80.0))
        nameLabel.text = "Soum"
        nameLabel.textAlignment = .center
        nameLabel.textColor = backgroundGray
        nameLabel.font = UIFont(name: "Inter-Black", size: 64.0)
        self.view.addSubview(nameLabel)
        
        let lifetime = UILabel(frame: CGRect(x: 0.0, y: 320.0, width: screenWidth, height: 40.0))
        lifetime.text = "Accuracy"
        lifetime.textAlignment = .center
        lifetime.textColor = grayShadow
        lifetime.font = UIFont(name: "Inter-Light", size: 28.0)
        self.view.addSubview(lifetime)
        
        let stat1 = UILabel(frame: CGRect(x: 0.0, y: 360.0, width: screenWidth, height: 60.0))
        stat1.text = "62.5%"
        stat1.textAlignment = .center
        stat1.font = UIFont(name: "Inter-Black", size: 45.0)
        self.view.addSubview(stat1)
        
        let complete = UILabel(frame: CGRect(x: 0.0, y: 440.0, width: screenWidth, height: 40.0))
        complete.text = "Completed"
        complete.textAlignment = .center
        complete.textColor = grayShadow
        complete.font = UIFont(name: "Inter-Light", size: 28.0)
        self.view.addSubview(complete)
        
        let stat2 = UILabel(frame: CGRect(x: 0.0, y: 480.0, width: screenWidth, height: 60.0))
        stat2.text = "6"
        stat2.textAlignment = .center
        stat2.font = UIFont(name: "Inter-Black", size: 45.0)
        self.view.addSubview(stat2)
        
        let button = UIButton()
        button.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        button.backgroundColor = backgroundGray
        let shadow = UIView(frame: CGRect(x: 40.0+10.0, y: screenHeight-140.0+10.0, width: screenWidth-80.0, height: 80.0))
        shadow.backgroundColor = grayShadow
        self.view.addSubview(shadow)
        self.view.addSubview(button)
        
        let tryLabel = UILabel(frame: button.bounds)
        tryLabel.text = "BACK"
        tryLabel.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel.textAlignment = .center
        tryLabel.textColor = foregroundGreen
        button.addSubview(tryLabel)
        // button.addTarget(self, action: #selector(co), for: .touchUpInside)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 40.0, y: screenHeight-260.0, width: screenWidth-80.0, height: 80.0)
        button2.backgroundColor = backgroundGray
        let shadow2 = UIView(frame: CGRect(x: 40.0+10.0, y: screenHeight-260.0+10.0, width: screenWidth-80.0, height: 80.0))
        shadow2.backgroundColor = grayShadow
        self.view.addSubview(shadow2)
        self.view.addSubview(button2)
        
        let tryLabel2 = UILabel(frame: button2.bounds)
        tryLabel2.text = "VIEW FRIENDS"
        tryLabel2.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel2.textAlignment = .center
        tryLabel2.textColor = foregroundGreen
        button2.addSubview(tryLabel2)
        // button.addTarget(self, action: #selector(co), for: .touchUpInside)
        
    }
    
}
