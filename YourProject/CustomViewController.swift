//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import AVFoundation
import CoreML
import Vision
import SnapKit

class CustomViewController: UIViewController {
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var videoOutput: AVCaptureVideoDataOutput!
    
    private var isCapturingVideo = false
    
    lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Video", for: .normal)
        button.addTarget(self,
                         action: #selector(toggleVideoCapture),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Result"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCaptureSession()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(toggleButton)
        toggleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toggleButton.snp.top).offset(-20)
        }
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
        
//        videoPreviewLayer.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    @objc private func toggleVideoCapture() {
        if isCapturingVideo {
            captureSession.stopRunning()
            toggleButton.setTitle("Start Video", for: .normal)
        } else {
            captureSession.startRunning()
            toggleButton.setTitle("Stop Video", for: .normal)
        }
        isCapturingVideo.toggle()
    }
}

extension CustomViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let famlilyMemberClassifier = try! FamlilyMemberClassifier_v1()
        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: famlilyMemberClassifier.model)) { (request, error) in
            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                DispatchQueue.main.async {
                    self.resultLabel.text = "\(topResult.identifier) (\(topResult.confidence * 100)%)"
                }
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }
}
