//
//  InfoHeaderView.swift
//  YourProject
//
//  Created by IntrodexMini on 7/5/2568 BE.
//

import UIKit
import SnapKit
import SwiftUI

class InfoHeaderView: UIView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snap_logo") // Add this asset to your project
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.2, alpha: 1) // Snap yellow
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Snap, Inc."
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .label
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "SNAP"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "About Snap, Inc."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()
    
    private let aboutDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Snap is a technology company known for its flagship product, Snapchat, a visual messaging app featuring Stories, Snap Map, and more. They also produce Spectacles, eyewear that captures photos and videos, along with innovative advertising solutions like AR ads."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
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
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(logoImageView)
        addSubview(companyNameLabel)
        addSubview(tickerLabel)
        addSubview(aboutTitleLabel)
        addSubview(aboutDescriptionLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(64)
        }
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView).offset(8)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        tickerLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(2)
            make.left.equalTo(companyNameLabel)
            make.right.equalTo(companyNameLabel)
        }
        aboutTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(24)
            make.left.equalTo(logoImageView)
            make.right.equalToSuperview().inset(16)
        }
        aboutDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(aboutTitleLabel)
            make.right.equalTo(aboutTitleLabel)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

struct InfoHeaderViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> InfoHeaderView {
        let view = InfoHeaderView(frame: .zero)
        return view
    }
    func updateUIView(_ uiView: InfoHeaderView, context: Context) {}
}

struct InfoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoHeaderViewRepresentable()
                .frame(height: 300)
                .border(.red, width: 1.0)
                .background(Color(.systemBackground))
                .padding()
                .border(Color.gray)
        }
    }
}

