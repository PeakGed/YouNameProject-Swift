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
import CoreVideo

class CustomViewController: UIViewController {
    
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var videoOutput: AVCaptureVideoDataOutput!
    var faceDetectionRequest: VNDetectFaceRectanglesRequest!
    var familyClassificationRequest: VNCoreMLRequest!
    
    private var isCapturingVideo = false
    
    lazy var toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Video", for: .normal)
        button.addTarget(self,
                         action: #selector(toggleVideoCapture),
                         for: .touchUpInside)
        button.backgroundColor = .black
        button.setTitleColor(.white,
                             for: .normal)
        return button
    }()
    
//    lazy var resultLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.text = "Result"
//        label.textColor = .white
//        label.backgroundColor = .black
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCaptureSession()
        setupVision()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(toggleButton)
        
        toggleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
//        view.addSubview(resultLabel)
//        resultLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(toggleButton.snp.top).offset(-20)
//        }
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
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
        
        // Configure autofocus and auto exposure
        if videoCaptureDevice.isFocusModeSupported(.continuousAutoFocus) {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.focusMode = .continuousAutoFocus
            videoCaptureDevice.unlockForConfiguration()
        }
        
        if videoCaptureDevice.isExposureModeSupported(.continuousAutoExposure) {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.exposureMode = .continuousAutoExposure
            videoCaptureDevice.unlockForConfiguration()
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
        
    }
    
    func setupVision() {
        faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            if let results = request.results as? [VNFaceObservation] {
                self.handleFaceDetectionResults(results)
            }
        })
        
        let ml = try! FamlilyMemberClassifier_v1()
        let model = try! VNCoreMLModel(for: ml.model)
        
        familyClassificationRequest = VNCoreMLRequest(model: model,
                                                      completionHandler: { (request, error) in
            if let results = request.results as? [VNClassificationObservation] {
                self.handleFamilyClassificationResults(results)
            }
        })
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
    
    
    // use face and location detector and create bound frame around face
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                   orientation: .right,
                                                   options: [:])
        do {
            try requestHandler.perform([faceDetectionRequest])
        } catch {
            print(error)
        }
    }
    
    //draw frame around face
//    func handleFaceDetectionResults(_ results: [VNFaceObservation]) {
//        DispatchQueue.main.async {
//
//            // Remove all previous face views
//            self.view.subviews.filter { $0 is RectView }.forEach { $0.removeFromSuperview() }
//
//            let faceRects = self.createFaceRects(result: results)
//            faceRects.forEach { self.view.addSubview($0) }
//
//
//            // Capture the current frame as an image
//            guard let currentFrameImage = self.captureCurrentFrameAsImage() else { return }
//
//            // Crop the image using the bounding boxes
//            let croppedImages = results.map { faceObservation -> UIImage? in
//                let boundingBox = faceObservation.boundingBox
//                return self.cropImage(image: currentFrameImage,
//                                      boundingBox: boundingBox)
//            }.compactMap { $0 }
//
//            // Perform family classification on the cropped images
//            croppedImages.forEach { croppedImage in
//                let handler = VNImageRequestHandler(cgImage: croppedImage.cgImage!,
//                                                    options: [:])
//                try? handler.perform([self.familyClassificationRequest])
//            }
//
//            // when get result update on RectView.titleLabel.text with the result
//
//
//        }
//    }
    
    func handleFamilyClassificationResults(_ results: [VNClassificationObservation]) {
        DispatchQueue.main.async {
            print("### handleFamilyClassificationResults")
            print(results)
            
            if let topResult = results.first {
                //self.resultLabel.text = "\(topResult.identifier) (\(topResult.confidence * 100)%)"
                print("### topResult")
                print("\(topResult.identifier) (\(topResult.confidence * 100)%)")
            }
        }
    }
    
    func createFaceRects(result: [VNFaceObservation]) -> [RectView] {
        var faceRects: [RectView] = result.map({
            let width = self.view.frame.width
            let height = self.view.frame.height
            let boundingBox = $0.boundingBox
            
            let size = CGSize(width: boundingBox.width * width,
                              height: boundingBox.height * height)
            let origin = CGPoint(x: boundingBox.minX * width,
                                 y: (1 - boundingBox.minY) * height - size.height)
            
            let faceView = RectView(frame: CGRect(origin: origin,
                                                  size: size))
            //faceView.confidentLabel.text = String(format: "%.2f", $0.confidence)
            return faceView
        })
        
//        let corpImages: [UIImage?] = result.map({
//            let width = self.view.frame.width
//            let height = self.view.frame.height
//            let boundingBox = $0.boundingBox
//
//            let size = CGSize(width: boundingBox.width * width,
//                              height: boundingBox.height * height)
//            let origin = CGPoint(x: boundingBox.minX * width,
//                                 y: (1 - boundingBox.minY) * height - size.height)
//
//            let image = self.cropImage(image: self.currentImage, rect: CGRect(origin: origin, size: size))
//            return image
//        })]
        
        return faceRects
    }
    
    
    // use family classify model
//    func captureOutput(_ output: AVCaptureOutput,
//                       didOutput sampleBuffer: CMSampleBuffer,
//                       from connection: AVCaptureConnection) {
//        guard let pixelBuffer: CVImageBuffer? = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//
//        let famlilyMemberClassifier = try! FamlilyMemberClassifier_v1()
//        let request = VNCoreMLRequest(model: try! VNCoreMLModel(for: famlilyMemberClassifier.model)) { (request, error) in
//            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
//                DispatchQueue.main.async {
//                    self.resultLabel.text = "\(topResult.identifier) (\(topResult.confidence * 100)%)"
//                }
//            }
//        }
//
//        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
//        try? handler.perform([request])
//    }
    
    func runFamilyClassifyRequest(pixelBuffer: CVImageBuffer) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                            options: [:])
        try? handler.perform([familyClassificationRequest])
    }
    
    
    // new
    func handleFaceDetectionResults(_ results: [VNFaceObservation]) {
        DispatchQueue.main.async {
            // Remove all previous face views
            self.view.subviews.filter { $0 is RectView }.forEach { $0.removeFromSuperview() }

            // Capture the current frame as an image
            guard let currentFrameImage = self.captureCurrentFrameAsImage() else { return }

            // Create face rectangles and add them to the view
            let faceRects = self.createFaceRects(result: results)
            faceRects.forEach { self.view.addSubview($0) }
            
            // Crop the image using the bounding boxes and classify each face
            for (index, faceObservation) in results.enumerated() {
                let boundingBox = faceObservation.boundingBox
                if let croppedImage = self.cropImage(image: currentFrameImage,
                                                     boundingBox: boundingBox),
                   let pixelBuffer = self.pixelBufferFromImage(image: croppedImage) {
                    self.runFamilyClassifyRequest(pixelBuffer: pixelBuffer) { [weak self]
                        classificationResult in
                        
                        guard let result = classificationResult else { return }
                        
                        DispatchQueue.main.async {
                            faceRects[index].titleLabel.text = result.identifier
                            faceRects[index].confidentLabel.text = result.confidence.description
                            //self?.view.addSubview(faceRects[index])
                        }
                    }
                }
            }
        }
    }

    private func runFamilyClassifyRequest(pixelBuffer: CVPixelBuffer,
                                          completion: @escaping (VNClassificationObservation?) -> Void) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let ml = try! FamlilyMemberClassifier_v1()
        let model = try! VNCoreMLModel(for: ml.model)
        let request = VNCoreMLRequest(model: model) { (request, error) in
                 
            print("count : \(request.results?.count ?? 0)")
            
            let r = request.results
            r?.forEach({
                print($0)
                let c = $0.confidence
            })
            
            let results = request.results?.first(where: {
                $0.confidence > 0.5
            }) as? [VNClassificationObservation] ?? []
            
            guard results.count > 0 else {
                completion(nil)
                return
            }
            
            results.forEach({
                print("##################")
                print("### \($0.identifier)")
                print("### \($0.confidence.description)")
            })
            
            if let topResult = results.sorted(by: {
                $0.confidence > $1.confidence
            }).first {
                
                // topResult.identifier , topResult.confidence
                completion(topResult)
            } else {
                completion(nil)
            }
        }
        try? handler.perform([request])
    }

}

extension CustomViewController {
    private func captureCurrentFrameAsImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func cropImage(image: UIImage,
                   boundingBox: CGRect) -> UIImage? {
        let width = image.size.width * boundingBox.width
        let height = image.size.height * boundingBox.height
        let x = image.size.width * boundingBox.origin.x
        let y = image.size.height * (1 - boundingBox.origin.y - boundingBox.height)
        
        let cropRect = CGRect(x: x, y: y, width: width, height: height)
        
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
    
    func pixelBufferFromImage(image: UIImage) -> CVPixelBuffer? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let attributes: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, attributes as CFDictionary, &pixelBuffer)
        
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(buffer, [])
        
        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        guard let ctx = context else {
            return nil
        }
        
        ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        CVPixelBufferUnlockBaseAddress(buffer, [])
        
        return buffer
    }
}


class RectView: UIView {
    
    lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.backgroundColor = .black
        element.text = ""
        element.textAlignment = .left
        return element
    }()
    
    lazy var confidentLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.backgroundColor = .black
        element.text = ""
        element.textAlignment = .left
        return element
    }()
    
    lazy var frameView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor.green.cgColor
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
        initConstriantLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initViews()
        initConstriantLayout()
    }
    
    private func initViews() {
        clipsToBounds = false
        
        self.addSubview(frameView)
        self.addSubview(titleLabel)
        self.addSubview(confidentLabel)
    }
    
    private func initConstriantLayout() {
        
        frameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints({ make in
            make.left.equalTo(frameView.snp.right)
            make.top.equalTo(frameView.snp.top)
            make.height.equalTo(23)
        })
        
        confidentLabel.snp.makeConstraints({ make in
            make.left.equalTo(frameView.snp.right)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(23)
        })
        
    }
}
