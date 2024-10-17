//
//  PopUpAction.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//


import UIKit

// MARK: - RKDialogAction

struct PopUpMenuActionStyle {
    let normalTextColor: UIColor
    let highlightedTextColor: UIColor
    let normalBackgroundColor: UIColor
    let highlightedBackgroundColor: UIColor
    let normalFont: UIFont
    let highlightedFont: UIFont

    static let unselected = PopUpMenuActionStyle(normalTextColor: .black,
                                                highlightedTextColor: .white,
                                                normalBackgroundColor: .white,
                                                highlightedBackgroundColor: .black,
                                                normalFont: .systemFont(ofSize: 16),
                                                highlightedFont: .systemFont(ofSize: 16))
    static let selected = PopUpMenuActionStyle(normalTextColor: .white,
                                                highlightedTextColor: .black,
                                                normalBackgroundColor: .black,
                                                highlightedBackgroundColor: .white,
                                                normalFont: .systemFont(ofSize: 16),
                                                highlightedFont: .systemFont(ofSize: 16))
}


public class PopUpMenuAction {
    
    var identifier: String
    var title: String
    var style: PopUpMenuActionStyle = .unselected
    var closure: ((_ identifier: String) -> Void)?
    var autoDismissWhenTakeAction: Bool = true
    var accessibilityIdentifier: String?
    var dismiss: (() -> Void)?

    init(identifier: String,
         title: String,
         style: PopUpMenuActionStyle = .unselected,
         autoDismissWhenTakeAction: Bool = true,
         accessibilityIdentifier: String? = nil,
         closure: ((_ identifier: String) -> Void)?,
         dismiss: (() -> Void)? = nil) {
        self.identifier = identifier
        self.title = title
        self.style = style
        self.autoDismissWhenTakeAction = autoDismissWhenTakeAction
        self.closure = closure
        self.accessibilityIdentifier = accessibilityIdentifier
        self.dismiss = dismiss
    }
    
    deinit {
        print("PopUpMenuAction deinit")
    }

    @objc
    func takeAction() {
        if let closure = closure {
            closure(identifier)
        }
        
        if autoDismissWhenTakeAction {
            if let dismiss = dismiss {
                dismiss()
            }
        }
    }
    
    func toButton() -> UIButton {
        let element = UIButton()
        element.setTitle(title, for: .normal)
        element.setTitleColor(.red, for: .highlighted)
        element.setTitleColor(.gray, for: .disabled)
        element.addTarget(self,
                          action: #selector(takeAction),
                          for: .touchUpInside)
        element.accessibilityIdentifier = accessibilityIdentifier

        element.setTitleColor(.darkGray, for: .normal)
        element.backgroundColor = .white
        element.isEnabled = true
        
        return element
    }
    
}
