//
//  PopUpMenu.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//

import UIKit

class PopUpMenu {
    
    private var rootView: UIView
    private var actions: [PopUpMenuAction] = []
    
    var dismissOnTapOutside: Bool = true
    var didDismiss: (() -> Void)? = nil
    
    var menuView: MenuView? // Updated to use MenuView
    
    lazy var placeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.5
        return view
    }()
    
    private var tapToDismissGesture: UITapGestureRecognizer? = nil
    
    init(rootView: UIView) {
        self.rootView = rootView
    }

    func present(targetView: UIView,
                 minSize: CGSize = .zero,
                 maxSize: CGSize = .init(width: 1000,
                                         height: 1000),
                 direction: PermitDirectiton = .up,
                 position: Position = .right,
                 actions: [PopUpMenuAction]) {

        let identifiers = actions.map { $0.identifier }
        let uniqueIdentifiers = Set(identifiers)
        
        if identifiers.count != uniqueIdentifiers.count {
            fatalError("Duplicate identifiers found in actions.")
        }
        
        guard menuView == nil else {
            print("Menu is already presented, skipping.")
            dismissMenu()
            return
        }
        
        // remove all previous MenuView
        rootView.subviews.forEach { subview in
            if subview is MenuView {
                subview.removeFromSuperview()
            }
            if subview === placeHolderView {
                subview.removeFromSuperview()
            }
        }

        self.actions = actions

        menuView = MenuView()
        menuView?.didDismiss = { [weak self] in
            self?.dismissMenu() // remove placeholder view
        }
        guard let menuView = menuView else { return }
        
        rootView.addSubview(placeHolderView)
        rootView.bringSubviewToFront(targetView)
        rootView.addSubview(menuView)
        
        placeHolderView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        menuView.setupView(popupActions: actions,
                           minSize: minSize,
                           maxSize: maxSize,
                           direction: direction,
                           position: position,
                           targetView: targetView,
                           rootView: rootView)

        // Dismiss on tap outside
        if dismissOnTapOutside {
            tapToDismissGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(handleTapOutside))
            placeHolderView.addGestureRecognizer(tapToDismissGesture!)
            placeHolderView.isUserInteractionEnabled = true
        }
    }
    
    @objc
    func handleTapOutside(_ sender: UITapGestureRecognizer) {
        print("Tap outside detected")
        dismissMenu()
    }
    
    func dismissMenu() {
        //rootView.subviews.removeAll(where: { $0 === menuView })
        menuView?.removeFromSuperview() // Updated to explicitly remove menuView from superview
        placeHolderView.removeFromSuperview()
        didDismiss?()

        if let tapToDismissGesture {
            placeHolderView.removeGestureRecognizer(tapToDismissGesture)
        }
        tapToDismissGesture = nil
    }
    

}

extension PopUpMenu {
    enum PermitDirectiton {
        case up
        case down
    }

    // Frame position when present with related to this config
    enum Position {
        case left // present on align same left on targetView
        case right // present on align same right on targetView
        case center // present on align center on targetView
    }
}
