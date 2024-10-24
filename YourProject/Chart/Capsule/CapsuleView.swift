//
//  CapsuleView.swift
//  YourProject
//
//  Created by IntrodexMac on 24/10/2567 BE.
//

import SnapKit
import UIKit

class CapsuleView: UIView {
    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Left"
        return label
    }()

    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Right"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(leftTitleLabel)
        addSubview(rightTitleLabel)

        initLayout()
    }

    func initLayout() {
        leftTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(30)
        }

        rightTitleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(leftTitleLabel.snp.right).offset(8)
        }
    }

    func configure(leftTitle: String,
                   rightTitle: String)
    {
        leftTitleLabel.text = leftTitle
        rightTitleLabel.text = rightTitle
    }
}
