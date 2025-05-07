//
//  MainViewController.swift
//  YourProject
//
//  Created by IntrodexMini on 7/5/2568 BE.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let infoHeaderView = InfoHeaderView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let controlVC = ControlViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHeader()
        setupScrollView()
        setupControlVC()
    }
    
    private func setupHeader() {
        infoHeaderView.layer.borderColor = UIColor.systemGray.cgColor
        infoHeaderView.layer.borderWidth = 1
        infoHeaderView.isUserInteractionEnabled = false
        
        view.addSubview(infoHeaderView)
        
        infoHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func setupScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        scrollView.layer.borderColor = UIColor.red.cgColor
        scrollView.layer.borderWidth = 1
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.contentInset = UIEdgeInsets(top: 380, left: 0, bottom: 0, right: 0)
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(2000)
        }
    }
    
    private func setupControlVC() {
        controlVC.delegate = self
        
        addChild(controlVC)
        
        contentView.addSubview(controlVC.view)
        
        controlVC.view.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            //make.height.equalTo(1000)
            //make.height.greaterThanOrEqualTo(1000)
            make.bottom.equalToSuperview() // This will allow contentView's height to match controlVC.view's height
        }
        controlVC.didMove(toParent: self)
        // Optionally, observe content size changes if you want to update scrollView's content size dynamically
    }
  
}

extension MainViewController: ContentViewControllerDelegate {
    func contentViewScrollViewDidScroll(_ childScrollView: UIScrollView) {
//        let childOffsetY = childScrollView.contentOffset.y
//
//        // Adjust for your top offset (e.g., header height or contentInset.top)
//        let topOffset: CGFloat = 500.0 //scrollView.contentInset.top // or use a fixed value like 380
//
//        var parentOffset = scrollView.contentOffset
//        parentOffset.y = childOffsetY - topOffset
//        scrollView.setContentOffset(parentOffset, animated: false)
//
//        print("Mov offset child scrollView: \(parentOffset)")
//        print("Move parent scrollView (adjusted for top offset)")
    }
}

// swift preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {}
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
            .previewLayout(.sizeThatFits)
    }
}

#endif
