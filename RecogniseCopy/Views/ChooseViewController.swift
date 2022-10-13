//
//  ChooseViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    let topLabel = UILabel()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = foregroundGreen

        // Do any additional setup after loading the view.
        topLabel.text = "CHOOSE A SET"
        topLabel.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight/4.0)
        topLabel.textAlignment = .center
        topLabel.textColor = backgroundGray
        topLabel.font = UIFont(name: "Inter-Black", size: 28.0)
        view.addSubview(topLabel)
        
        // test sets
        
        scrollView.frame = CGRect(x: 0.0, y: screenHeight/4.0, width: screenWidth, height: screenWidth)
        
        let margin = 60.0
        
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        
        var currentX = margin
        let withWidth = Double(screenWidth) - 2 * margin
        
        var setNum = 0
        
        for set in availableSets {
            let (renderedVersion, buttonDisp) = getRenderedDisplay(forSet: set, withWidth: withWidth)
            renderedVersion.frame = CGRect(x: currentX, y: margin, width: withWidth, height: withWidth)
            let shadowBox = UIView(frame: CGRect(x: currentX+20.0, y: margin+20.0, width: withWidth, height: withWidth))
            shadowBox.backgroundColor = grayShadow
            scrollView.addSubview(shadowBox)
            scrollView.addSubview(renderedVersion)
            
            
            
            buttonDisp.tag = setNum
            buttonDisp.addTarget(self, action: #selector(goTo), for: .touchUpInside)
            
            currentX += Double(screenWidth)
            setNum += 1
        }
        
        currentX -= margin
        
        scrollView.contentSize = CGSize(width: currentX, height: Double(screenWidth))
        
        self.view.addSubview(scrollView)
        
        let button = UIButton()
        button.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        button.backgroundColor = backgroundGray
        let shadow = UIView(frame: CGRect(x: 40.0+10.0, y: screenHeight-140.0+10.0, width: screenWidth-80.0, height: 80.0))
        shadow.backgroundColor = grayShadow
        self.view.addSubview(shadow)
        self.view.addSubview(button)
        
        let tryLabel = UILabel(frame: button.bounds)
        tryLabel.text = "ADD"
        tryLabel.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel.textAlignment = .center
        tryLabel.textColor = foregroundGreen
        button.addSubview(tryLabel)
        button.addTarget(self, action: #selector(co), for: .touchUpInside)
        
    }
    
    @objc func co() {
        let tr = SetViewController()
        tr.modalPresentationStyle = .fullScreen
        present(tr, animated: true, completion: nil)
    }
    
    @objc func goTo(_ sender: UIButton) {
        print(sender.tag)
        currentSet = availableSets[sender.tag]
        
        let vc = LearnViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }

}
