//
//  SetViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit

func getNext(_ curr: String) -> String {
    if (curr == "Easy") {
        return "Medium"
    }
    if (curr == "Medium") {
        return "Hard"
    }
    if (curr == "Hard") {
        return "Insane"
    }
    if (curr == "Insane") {
        return "Easy"
    }
    assert(false)
}

class SetViewController: UIViewController, UITextFieldDelegate {

    let addField = UITextField()
    let addButton = UIButton()
    let doneButton = UIButton()
    
    var words = [String]()
    let insLabel = UILabel()
    var curr = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = foregroundGreen
        
        let topLabel = UILabel()
        topLabel.text = "NEW SET"
        topLabel.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight/4.0)
        topLabel.textAlignment = .center
        topLabel.textColor = backgroundGray
        topLabel.font = UIFont(name: "Inter-Black", size: 28.0)
        view.addSubview(topLabel)
        
        let treButton = UIButton()
        treButton.frame = CGRect(x: 40.0, y: screenHeight/4+40.0, width: screenWidth-80.0, height: 80.0)
        treButton.backgroundColor = backgroundGray
        treButton.addTarget(self, action: #selector(changeDiff), for: .touchUpInside)
        insLabel.frame = treButton.bounds
        insLabel.text = "Difficulty: " + curr
        insLabel.font = UIFont(name: "Inter-Regular", size: 24.0)
        insLabel.textAlignment = .center
        insLabel.textColor = getDifficultyColour(curr)
        treButton.addSubview(insLabel)
        view.addSubview(treButton)
        
        addField.frame = CGRect(x: 40.0, y: screenHeight-380.0, width: screenWidth-80.0, height: 80.0)
        addField.textColor = foregroundGreen
        addField.backgroundColor = grayShadow
        addField.delegate = self
        addField.placeholder = "Type a word to add"
        addField.font = UIFont(name: "Inter-Light", size: 24.0)
        self.view.addSubview(addField)
        
        
        
        addButton.frame = CGRect(x: 40.0, y: screenHeight-260.0, width: screenWidth-80.0, height: 80.0)
        addButton.backgroundColor = backgroundGray
        addButton.addTarget(self, action: #selector(didAdd), for: .touchUpInside)
        let addLabel = UILabel(frame: addButton.bounds)
        addLabel.text = "ADD"
        addLabel.textAlignment = .center
        addLabel.font = UIFont(name: "Inter-Regular", size: 24.0)
        addLabel.textColor = foregroundGreen
        addButton.addSubview(addLabel)
        self.view.addSubview(addButton)
        
        doneButton.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        doneButton.backgroundColor = backgroundGray
        doneButton.addTarget(self, action: #selector(didDone), for: .touchUpInside)
        let doneLabel = UILabel(frame: doneButton.bounds)
        doneLabel.text = "DONE"
        doneLabel.textColor = foregroundGreen
        doneLabel.textAlignment = .center
        doneLabel.font = UIFont(name: "Inter-Regular", size: 24.0)
        doneButton.addSubview(doneLabel)
        self.view.addSubview(doneButton)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didAdd() {
        words.append(addField.text!)
        addField.text = ""
    }
    
    @objc func changeDiff() {
        curr = getNext(curr)
        insLabel.text = "Difficulty: " + curr
        insLabel.textColor = getDifficultyColour(curr)
    }
    
    @objc func didDone() {
        let newSet = FlashcardSet(withName: "Custom Set", withDifficulty: curr, withWords: words)
        availableSets.append(newSet)
        let nwt = ChooseViewController()
        nwt.modalPresentationStyle = .fullScreen
        present(nwt, animated: true, completion: nil)
    }
    
}
