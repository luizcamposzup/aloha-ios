//
//  PhotoViewController.swift
//  AlohaIOS
//
//  Created by zupper on 04/12/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PhotoViewController: BaseViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image : UIImage?
    
    @IBOutlet weak var cameraView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
        func setupCaptureSession(){
           captureSession.sessionPreset = AVCaptureSession.Preset.photo
       }

        func setupDevice(){
           let devideDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
           let devices = devideDiscoverySession.devices
           
           for device in devices {
               if device.position == AVCaptureDevice.Position.front {
                   self.frontCamera = device
               } else if device.position == AVCaptureDevice.Position.back {
                   self.backCamera = device
               }
           }
           
           currentCamera = frontCamera
       }
       
        func setupInputOutput(){
           do {
             let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
               captureSession.addInput(captureDeviceInput)
               photoOutput = AVCapturePhotoOutput()
               photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
               captureSession.addOutput(photoOutput!)
               
           } catch {
               print(error)
           }
           
       }
       
        func setupPreviewLayer(){
           cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
           cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
           cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
           cameraPreviewLayer?.frame = cameraView.bounds
           
           cameraView.layer.addSublayer(cameraPreviewLayer!)
           cameraView.layer.masksToBounds = true
           cameraView.layer.cornerRadius = self.cameraView.frame.height / 30.0
           
       }
       
        func startRunningCaptureSession(){
           captureSession.startRunning()
           
       }
    
    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        callNext(viewController: "DataViewController")
    }
    
    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        //callNext(viewController: "ConfirmViewController")
    }
    
    @IBAction func jumpViewControllerWhenButtonTouchUpInside(_ sender: Any) {
        callNext(viewController: "ConfirmViewController")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showPhotoSegue" {
               let previewVC = segue.destination as! PreviewViewController
               previewVC.image = self.image
           }
           
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    
}


extension PhotoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
}
