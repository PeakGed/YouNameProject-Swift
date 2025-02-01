//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit

class CustomViewController: UIViewController {
    
    lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Hello world"
        element.textAlignment = .left
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
        
        Task {
            do {
                try await AuthRemoteService()
                    .emailLogin(request: .init(username: "test1@email.com",
                                                              password: "12345678"))
            } catch {
                print(error)
            }
        }
        
        
    }
    
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
    }
    
    private func initConstriantLayout() {
        nameLabel.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        })
    }
}
