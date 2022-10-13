//
//  Engine.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import Foundation
import UIKit
import CoreML

var availableSets = [FlashcardSet]()
var currentSet = FlashcardSet()

class FlashcardSet {
    
    var words = [String]()
    var difficulty = ""
    var setName = ""
    
    init(withName: String, withDifficulty: String, withWords: [String]) {
        difficulty = withDifficulty
        words = withWords
        setName = withName
    }
    
    init() {
        difficulty = "Easy"
    }
    
}

func getDifficultyColour(_ difficulty: String) -> UIColor {
    if (difficulty == "Easy") {
        return .green
    }
    else if (difficulty == "Medium") {
        return .orange
    }
    else if (difficulty == "Hard") {
        return .red
    }
    else if (difficulty == "Insane") {
        return .systemRed
    }
    assert(false, "Difficulty: \(difficulty) does not exist.")
}

func getDifficultyNumber(_ difficulty: String) -> Int {
    if (difficulty == "Easy") {
        return 1
    }
    else if (difficulty == "Medium") {
        return 2
    }
    else if (difficulty == "Hard") {
        return 3
    }
    else if (difficulty == "Insane") {
        return 4
    }
    assert(false, "Difficulty: \(difficulty) does not exist.")
}

func getRenderedDisplay(forSet: FlashcardSet, withWidth: Double) -> (UIView, UIButton) {
    
    let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: withWidth, height: withWidth))
    view.backgroundColor = backgroundGray
    
    let viewTitleLabel = UILabel()
    viewTitleLabel.text = forSet.setName
    viewTitleLabel.frame = CGRect(x: 25.0, y: 10.0, width: withWidth-20.0, height: 80.0)
    // viewTitleLabel.backgroundColor = .red
    viewTitleLabel.font = UIFont(name: "Inter-Regular", size: 22.0)
    viewTitleLabel.textColor = .white
    view.addSubview(viewTitleLabel)
    
    let wordsLabel = UITextView(frame: CGRect(x: 25.0, y: 65.0, width: withWidth-50.0, height: withWidth-115.0))
    wordsLabel.textColor = .lightGray
    wordsLabel.font = UIFont(name: "Inter-Light", size: 18.0)
    var words = ""
    var cou = 0
    for word in forSet.words {
        cou += 1
        if (cou > 4) { continue }
        words += word
        words += "\n"
    }
    wordsLabel.backgroundColor = .clear
    wordsLabel.text = words
    wordsLabel.layer.masksToBounds = true
    wordsLabel.clipsToBounds = true
    view.addSubview(wordsLabel)
    
    let colour = getDifficultyColour(forSet.difficulty)
    
    let difficultyLabel = UILabel()
    difficultyLabel.text = forSet.difficulty.uppercased()
    difficultyLabel.textColor = colour
    difficultyLabel.font = UIFont(name: "Inter-Light", size: 22.0)
    difficultyLabel.frame = CGRect(x: 25.0, y: withWidth-90.0, width: withWidth-20.0, height: 20.0)
    // difficultyLabel.backgroundColor = .red
    view.addSubview(difficultyLabel)
    
    let numCircles = getDifficultyNumber(forSet.difficulty)
    
    // size of 30
    let atY = withWidth - 25.0 - 30.0
    var atX = 25.0
    
    for _ in 0..<numCircles {
        let circle = UIView(frame: CGRect(x: atX, y: atY, width: 30.0, height: 30.0))
        circle.layer.cornerRadius = 15.0
        circle.backgroundColor = colour
        view.addSubview(circle)
        atX += 40.0
    }
    
    let button = UIButton()
    button.frame = view.bounds
    view.addSubview(button)
    
    return (view, button)
    
}


func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
}

func ensquareImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

    let scale = newWidth / image.size.width
    let newHeight = newWidth // squarify
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
}

func convertToArray(from mlMultiArray: MLMultiArray) -> [Double] {
    
    // Init our output array
    var array: [Double] = []
    
    // Get length
    let length = mlMultiArray.count
    
    // Set content of multi array to our out put array
    for i in 0...length - 1 {
        array.append(Double(truncating: mlMultiArray[[0,NSNumber(value: i)]]))
    }
    
    return array
}

/*
let path = Bundle.main.path(forResource: "modelIOSV2", ofType: "mlmodel")
let url = URL(fileURLWithPath: path!)
let model = try! modelIOSV2(contentsOf: url)*/

let model = modelIOSV2()

func predictWithImage(baseImage: UIImage) -> String {
    //
    // print(baseImage.size.width, baseImage.size.height)
    let resizedImage = ensquareImage(image: baseImage, newWidth: 224.0)!
    // print(resizedImage.size.width, resizedImage.size.height)
    let convValue = buffer(from: resizedImage)!
    
    guard let predictedOutput = try? model.prediction(input_3: convValue) else {
        fatalError("Unexpected model error.")
    }
    
    let result = predictedOutput.featureValue(for: "Identity")!
    
    let parallel = ["a", "b", "c", "d", "del", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "nothing", "o", "p", "q", "r", "s", "space", "t", "u", "v", "w", "x", "y", "z"]
    
    var mxs = 0.0
    
    let arrayForm = convertToArray(from: result.multiArrayValue!)
    
    for i in arrayForm {
        mxs = max(mxs, i)
    }
    
    for i in 0..<29 {
        if (arrayForm[i] == mxs) {
            return parallel[i]
        }
    }
    
    return "nothing"
    
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

var mistakes = [[String]]()
