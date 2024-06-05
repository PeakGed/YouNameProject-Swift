//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit
import FloatingPanel

class CustomViewController: UIViewController, FloatingPanelControllerDelegate {
    
    // contentVC to insert in FloatingPanel
    let contentVC = ContentViewController()
    
    lazy var fpc: FloatingPanelController = {
        let element = FloatingPanelController()
        
        // enable tap background Backdrop to dismiss panel
        element.backdropView.backgroundColor = .clear
        element.backdropView.dismissalTapGestureRecognizer.isEnabled = true

        element.delegate = self // optional
        element.layout = MyFloatingPanelLayout()
        element.contentMode = .fitToBounds // make contentView scalable
        
        // make surfaceView top left-right round cornor
        element.surfaceView.backgroundColor = .brown
        element.surfaceView.layer.cornerRadius = 20
        element.surfaceView.clipsToBounds = true
        element.surfaceView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
//        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // init contentVC
        element.set(contentViewController: contentVC)

        return element
    }()
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()
    
    lazy var showButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Show Panel",
                         for: .normal)
        element.setTitleColor(.white,
                              for: .normal)
        element.backgroundColor = .darkGray
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(showPanelVC),
                          for: .touchUpInside)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
        
    @objc
    func showPanelVC() {
        self.present(fpc,
                     animated: true,
                     completion: nil)
        
        // another call method
        //fpc.addPanel(toParent: self)
    }
    
    @objc
    func dismissPanel() {
        fpc.dismiss(animated: true,
                    completion: nil)
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(showButton)
    }
    
    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        showButton.snp.makeConstraints { make in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(100)
            make.height.equalTo(44)
        }
    }
    
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0,
                                        edge: .top,
                                         referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4,
                                         edge: .top,
                                         referenceGuide: .safeArea),
    ]
    
    // return 1 to make backdrop visible to touch
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        1
    }

}

//class CustomSurfaceView: FloatingPanelSurfaceView {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        // Apply the rounded corners to the top left and top right
//        let maskPath = UIBezierPath(roundedRect: self.bounds,
//                                    byRoundingCorners: [.topLeft, .topRight],
//                                    cornerRadii: CGSize(width: 16.0, height: 16.0)) // Adjust corner radius as needed
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = maskPath.cgPath
//        self.layer.mask = maskLayer
//    }
//}

class ContentViewController: UIViewController {
    
    //header view
    lazy var headerView: UIView = {
        let element = UIView()
        //element.backgroundColor = .yellow
        return element
    }()
    
    //content view
    lazy var contentView: UIView = {
        let element = UIView()
        element.backgroundColor = .green
        return element
    }()
    
    //closeButton
    lazy var closeButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Close",
                         for: .normal)
        element.setTitleColor(.white,
                              for: .normal)
        element.backgroundColor = .darkGray
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(closePanelVC),
                          for: .touchUpInside)
        return element
    }()
    
    lazy var footerLabel: UILabel = {
        let element = UILabel()
        element.text = "Footer Label"
        element.textAlignment = .center
        return element
    }()
    
    @objc
    func closePanelVC() {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
                
    }
    
    private func initViews() {
        self.view.backgroundColor = .red
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
                
        headerView.addSubview(closeButton)
        
        self.view.addSubview(headerView)
        self.view.addSubview(contentView)
        self.view.addSubview(footerLabel)
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
        print(view.bounds)
    }
    
    private func initConstriantLayout() {
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalToSuperview()
        }
        
        headerView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        })
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(footerLabel.snp.top)
        }
        
        footerLabel.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        })
        
    }
}


