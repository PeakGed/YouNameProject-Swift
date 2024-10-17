//
//  POCPopUpViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 16/10/2567 BE.
//

import Foundation
import SnapKit
import UIKit

class POCPopUpViewController: UIViewController {

    lazy var dropDownButton: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Button 1", for: .normal)
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(dropDownRightButtonTapped),
                          for: .touchUpInside)
        element.backgroundColor = .darkGray
        element.titleLabel?.textColor = .white
        return element
    }()
    
    lazy var dropDown2Button: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Button 2", for: .normal)
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(dropDownRightButtonTapped),
                          for: .touchUpInside)
        element.backgroundColor = .darkGray
        element.titleLabel?.textColor = .white
        return element
    }()
    
    
    lazy var dropDown3Button: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Button 3", for: .normal)
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(dropDownLeftButtonTapped),
                          for: .touchUpInside)
        element.backgroundColor = .darkGray
        element.titleLabel?.textColor = .white
        return element
    }()
    
    lazy var dropDown4Button: UIButton = {
        let element = UIButton(type: .custom)
        element.setTitle("Button 4", for: .normal)
        element.isEnabled = true
        element.addTarget(self,
                          action: #selector(dropDownLeftButtonTapped),
                          for: .touchUpInside)
        element.backgroundColor = .darkGray
        element.titleLabel?.textColor = .white
        return element
    }()
    
    lazy var selectedLabel: UILabel = {
        let element = UILabel()
        element.text = "None"
        element.textAlignment = .center
        return element
    }()
    
    @objc
    func dropDownRightButtonTapped(sender: UIButton) {
        showMenu(btn: sender, position: .right)
    }
    
    @objc
    func dropDownLeftButtonTapped(sender: UIButton) {
        showMenu(btn: sender, position: .left)
    }
    
    // tmp
    var pMenu: PopUpMenu?
    
    func showMenu(btn: UIButton,
                  position: PopUpMenu.Position = .right) {
        let menu = PopUpMenu(rootView: self.view)
        
        self.pMenu = menu
        
        menu.didDismiss = {
            print("Dismissed")
        }
        
        let actions: [PopUpMenuAction] = [
            .init(identifier: "1",
                  title: "1 Day",
                  style: .unselected,
                  closure: { [weak self] (identifier) in
                      print("\(identifier) selected")
                      self?.selectedLabel.text = "\(identifier) selected"
                  },dismiss: {
                      print("1 Day dismissed")
                  }),
            .init(identifier: "2",
                  title: "3 Month",
                  style: .unselected,
                  closure: { [weak self] (identifier) in
                      print("\(identifier) selected")
                      self?.selectedLabel.text = "\(identifier) selected"
                  },dismiss: {
                      print("3 Month dismissed")
                  }),
            .init(identifier: "3",
                  title: "6 Month",
                  style: .unselected,
                  closure: { [weak self] (identifier) in
                      print("\(identifier) selected")
                      self?.selectedLabel.text = "\(identifier) selected"
                  },dismiss: {
                      print("6 Month dismissed")
                  })
        ]

        menu.present(targetView: btn,
                     minSize: CGSize(width: 100, height: 100),
                     position: position,
                     actions: actions)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled = true
        
        self.view.addSubview(dropDownButton)
        self.view.addSubview(dropDown2Button)
        self.view.addSubview(dropDown3Button)
        self.view.addSubview(dropDown4Button)
        self.view.addSubview(selectedLabel)
        
        // Right side
        dropDownButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
        }
                
        dropDown2Button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(dropDownButton.snp.bottom).offset(20)
        }
        
        // Left side
        dropDown3Button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
        
        dropDown4Button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(dropDown3Button.snp.bottom).offset(20)
        }
        
        selectedLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
