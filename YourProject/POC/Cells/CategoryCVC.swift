//
//  CategoryCVC.swift
//  YourProject
//
//  Created by IntrodexMini on 7/5/2568 BE.
//

import UIKit
import SnapKit
import SwiftUI

class CategoryCVC: UICollectionViewCell {
    static let identifier = "CategoryCVC"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.98, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cloud Computing"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Vivamus in dui vel ex bibendum pulvinar. Mauris auctor metus ac metus blandit laoreet."
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    // Example icons (replace with your own images as needed)
    private let iconStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = -8
        stack.alignment = .center
        return stack
    }()
    
    private let plusBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "+4"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor.orange
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let seeWhoLabel: UILabel = {
        let label = UILabel()
        label.text = "See who's in the game"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(arrowImageView)
        containerView.addSubview(bottomButtonView)
        bottomButtonView.addSubview(iconStackView)
        bottomButtonView.addSubview(plusBadgeLabel)
        bottomButtonView.addSubview(seeWhoLabel)
        setupIcons()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIcons() {
        // Example: Add 4 system icons (replace with your own as needed)
        let icons = ["globe", "z.circle.fill", "bolt.circle.fill", "snapchat"]
        for iconName in icons {
            let iv = UIImageView(image: UIImage(systemName: iconName))
            iv.tintColor = .systemBlue
            iv.backgroundColor = .white
            iv.layer.cornerRadius = 12
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFit
            iv.snp.makeConstraints { $0.size.equalTo(CGSize(width: 24, height: 24)) }
            iconStackView.addArrangedSubview(iv)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.size.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.lessThanOrEqualTo(arrowImageView.snp.left).offset(-8)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(16)
            make.size.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().inset(16)
        }
        bottomButtonView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        iconStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        plusBadgeLabel.snp.makeConstraints { make in
            make.left.equalTo(iconStackView.snp.right).offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 20))
        }
        seeWhoLabel.snp.makeConstraints { make in
            make.left.equalTo(plusBadgeLabel.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualToSuperview().inset(12)
        }
    }
}

struct CategoryCVCRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        // Create a dummy frame for preview
        let cell = CategoryCVC(frame: CGRect(x: 0, y: 0, width: 350, height: 180))
        return cell.contentView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No-op for static preview
    }
}

struct CategoryCVC_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCVCRepresentable()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
