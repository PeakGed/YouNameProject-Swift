//
//  menuCollelctionViewCell.swift
//  YourProject
//
//  Created by IntrodexMac on 24/6/2567 BE.
//

import Foundation
import UIKit
import PagingKit

class MenuView: PagingMenuViewCell {
    
    lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.textColor = .black
        
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
    
    func bind(_ text: String) {
        titleLabel.text = text
    }
    
}


// MARK: - Layout
private extension MenuView {
    
    func initViews() {
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
    }
    
    func initConstriantLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
}
