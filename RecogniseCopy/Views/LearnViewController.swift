//
//  LearnViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

    let learn = UILabel()
    let image = UIImageView()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = foregroundGreen
        
        
        learn.frame = CGRect(x: 0.0, y: 40.0, width: screenWidth, height: 80.0)
        learn.text = "REVISE"
        learn.font = UIFont(name: "Inter-Black", size: 32.0)
        learn.textAlignment = .center
        learn.textColor = backgroundGray
        self.view.addSubview(learn)
        
        image.image = UIImage(named: "all")
        image.frame = CGRect(x: 20.0, y: 80.0, width: screenWidth-40.0, height: screenHeight-160.0)
        image.contentMode = .scaleAspectFit
        self.view.addSubview(image)
        
        button.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        button.backgroundColor = backgroundGray
        let shadow = UIView(frame: CGRect(x: 40.0+10.0, y: screenHeight-140.0+10.0, width: screenWidth-80.0, height: 80.0))
        shadow.backgroundColor = grayShadow
        self.view.addSubview(shadow)
        self.view.addSubview(button)
        
        let tryLabel = UILabel(frame: button.bounds)
        tryLabel.text = "READY"
        tryLabel.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel.textAlignment = .center
        tryLabel.textColor = foregroundGreen
        button.addSubview(tryLabel)
        button.addTarget(self, action: #selector(co), for: .touchUpInside)
        
    }
    
    @objc func co() {
        let tr = PlayViewController()
        tr.modalPresentationStyle = .fullScreen
        present(tr, animated: true, completion: nil)
    }

}
