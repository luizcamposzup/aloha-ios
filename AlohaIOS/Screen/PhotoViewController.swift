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
    
    @IBOutlet weak var cameraView: UIView!
    var captureSession = AVCaptureSession()
    var backCamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image : UIImage?
    var page : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }

    @IBAction func backViewControllerWhenButtonTouchUpInside() {
        backToPreviousViewController()
    }

    @IBAction func callNextViewControllerWhenButtonTouchUpInside() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    @IBAction func jumpViewControllerWhenButtonTouchUpInside(_ sender: Any) {
        nextViewController(vc: "ConfirmViewController")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showPhotoSegue" {
               let previewVC = segue.destination as! PreviewViewController
               previewVC.image = self.image
           }
    }
       
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    private func setupCaptureSession() {
           captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    private func setupDevice() {
       let devideDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
       let devices = devideDiscoverySession.devices
       for device in devices {
           if device.position == AVCaptureDevice.Position.front { self.frontCamera = device }
           else if device.position == AVCaptureDevice.Position.back { self.backCamera = device }
       }
       currentCamera = frontCamera
    }
       
    private func setupInputOutput() {
       do {
         let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
           captureSession.addInput(captureDeviceInput)
           photoOutput = AVCapturePhotoOutput()
           photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
           captureSession.addOutput(photoOutput!)
       } catch { print(error) }
    }
       
    private func setupPreviewLayer() {
       cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
       cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
       cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
       cameraPreviewLayer?.frame = cameraView.bounds
       cameraView.layer.addSublayer(cameraPreviewLayer!)
       cameraView.layer.masksToBounds = true
       cameraView.layer.cornerRadius = self.cameraView.frame.height / 30.0
    }

    private func startRunningCaptureSession() { captureSession.startRunning() }
}
    
extension PhotoViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
}
