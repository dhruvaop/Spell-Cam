//
//  PlayViewController.swift
//  RecogniseCopy
//
//  Copyright © 2021 HackathonCoding. All rights reserved.
//

import UIKit
import CoreML
import AVFoundation

class PlayViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    let previewView = UIView()
    let captureImageView = UIImageView()
    
    @objc func didTakePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        captureImageView.image = image
        print("Trying to predict!")
        
        workPredict(predictWithImage(baseImage: image!))
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }

    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        let videoDevices = AVCaptureDevice.devices(for: AVMediaType.video)
        var captureDevice: AVCaptureDevice?
        for device in videoDevices {
            if device.position == AVCaptureDevice.Position.front {
                captureDevice = device
                break
            }
        }
        guard let backCamera = captureDevice
        else {
            print("Unable to access back camera!")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            //Step 9
            stillImageOutput = AVCapturePhotoOutput()
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
        
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        //Step12
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    let currLabel = UILabel()
    let wordLabel = UILabel()
    let letterLabel = UILabel()
    
    let tryButton = UIButton()
    
    var letter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundGray
        
        // currentSet
        previewView.frame = self.view.bounds
        self.view.addSubview(previewView)
        
        currLabel.frame = CGRect(x: 0.0, y: 40.0, width: screenWidth, height: 30.0)
        currLabel.textAlignment = .center
        currLabel.text = "CURRENT WORD"
        currLabel.textColor = .white
        currLabel.font = UIFont(name: "Inter-Light", size: 16.0)
        self.view.addSubview(currLabel)
        
        wordLabel.frame = CGRect(x: 0.0, y: 70.0, width: screenWidth, height: 90.0)
        wordLabel.text = currentSet.words[0]
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont(name: "Inter-Black", size: 64.0)
        wordLabel.textColor = foregroundGreen
        self.view.addSubview(wordLabel)
        
        letterLabel.frame = CGRect(x: 0.0, y: 160.0, width: screenWidth, height: 90.0)
        letterLabel.text = currentSet.words[0][0]
        letterLabel.textAlignment = .center
        letterLabel.font = UIFont(name: "Inter-Black", size: 64.0)
        letterLabel.textColor = backgroundGray
        self.view.addSubview(letterLabel)
        
        let shadow = UIView()
        shadow.backgroundColor = greenShadow
        shadow.frame = CGRect(x: 40.0+10.0, y: screenHeight-140.0+10.0, width: screenWidth-80.0, height: 80.0)
        self.view.addSubview(shadow)
        
        tryButton.frame = CGRect(x: 40.0, y: screenHeight-140.0, width: screenWidth-80.0, height: 80.0)
        tryButton.backgroundColor = foregroundGreen
        tryButton.addTarget(self, action: #selector(didTakePhoto), for: .touchUpInside)
        // tryButton.layer.borderWidth = 2.0
        
        
        let tryLabel = UILabel(frame: tryButton.bounds)
        tryLabel.text = "TRY"
        tryLabel.font = UIFont(name: "Inter-Regular", size: 30.0)
        tryLabel.textAlignment = .center
        tryLabel.textColor = backgroundGray
        tryButton.addSubview(tryLabel)
        
        self.view.addSubview(tryButton)
        
        
        
    }
    
    func show(correct: Bool) {
        
        let frame = CGRect(x: screenWidth/2-120.0, y: screenHeight/2-120.0, width: 240.0, height: 240.0)
        let showView = UIView()
        showView.frame = frame
        showView.layer.cornerRadius = 40.0
        
        let img = UIImageView(frame: CGRect(x: 40.0, y: 40.0, width: 160.0, height: 160.0))
        
        if (correct) {
            showView.backgroundColor = .green
            img.image = UIImage(named: "check")
        }
        else {
            showView.backgroundColor = .red
            img.image = UIImage(named: "wrong")
        }
        
        showView.addSubview(img)
        
        self.view.addSubview(showView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showView.removeFromSuperview()
        }
        
    }
    
    func workPredict(_ with: String) {
        print("Prediction: ", with)
        if (with == currentSet.words[0][letter]) {
            print("Right!")
            show(correct: true)
            letter += 1
            if (letter == currentSet.words[0].length) {
                print("Set complete!")
                goOn()
            }
            else {
                letterLabel.text = currentSet.words[0][letter]
            }
        }
        else {
            print("Wrong")
            mistakes.append([currentSet.words[0][letter], with])
            show(correct: false)
        }
    }
    
    func goOn() {
        let resultsScreen = ResultsViewController()
        resultsScreen.modalPresentationStyle = .fullScreen
        self.present(resultsScreen, animated: true, completion: nil)
    }
    
    
}
