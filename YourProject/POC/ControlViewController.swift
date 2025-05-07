//
//  ControllViewController.swift
//  YourProject
//
//  Created by IntrodexMini on 7/5/2568 BE.
//

import Parchment
import UIKit
import SnapKit


class ControlViewController: UIViewController {
    
    var delegate: ContentViewControllerDelegate?
    
    var coreOfferingVCs: [ContentViewController] = []
    var researchDevVCs: [ContentViewController] = []
    
    var pagingViewController: PagingViewController!

    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Core Offering", "Research & Development"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add segmented control
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }        
        
        initVCs()   
        
        // Create the PagingViewController
        pagingViewController = PagingViewController(viewControllers: selectedVCs(index: segmentedControl.selectedSegmentIndex))
        
        // Add as child and constrain below segmented control using SnapKit
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        pagingViewController.didMove(toParent: self)
    }    

    func selectedVCs(index: Int) -> [ContentViewController] {
        return index == 0 ? coreOfferingVCs : researchDevVCs
    }
    
    func initVCs() {
        // Create two ContentViewController instances
        let firstCoreVC = ContentViewController()
        firstCoreVC.title = "Core: Category A"
        firstCoreVC.delegate = delegate

        let secondCoreVC = ContentViewController()
        secondCoreVC.title = "Core: Category B"
        secondCoreVC.delegate = delegate

        coreOfferingVCs = [firstCoreVC, secondCoreVC]
        
        // create research dev vcs
        let firstResearchDevVC = ContentViewController()
        firstResearchDevVC.title = "R&D: Category A"
        firstResearchDevVC.delegate = delegate

        let secondResearchDevVC = ContentViewController()   
        secondResearchDevVC.title = "R&D: Category B"
        secondResearchDevVC.delegate = delegate

        researchDevVCs = [firstResearchDevVC, secondResearchDevVC]
    }
    
    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        updateVCs(index: sender.selectedSegmentIndex)
    }

    func updateVCs(index: Int) {
        // Remove old pagingViewController
        pagingViewController?.willMove(toParent: nil)
        pagingViewController?.view.removeFromSuperview()
        pagingViewController?.removeFromParent()

        // Create new pagingViewController
        pagingViewController = PagingViewController(viewControllers: selectedVCs(index: index))
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        pagingViewController.didMove(toParent: self)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ControllViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ControlViewController {
        return ControlViewController()
    }
    func updateUIViewController(_ uiViewController: ControlViewController, context: Context) {}
}

struct ControllViewController_Previews: PreviewProvider {
    static var previews: some View {
        ControllViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
            .previewLayout(.sizeThatFits)
    }
}
#endif
