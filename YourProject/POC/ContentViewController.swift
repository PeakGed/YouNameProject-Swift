//
//  ContentViewController.swift
//  YourProject
//
//  Created by IntrodexMini on 7/5/2568 BE.
//

import UIKit
import SnapKit

protocol ContentViewControllerDelegate: AnyObject {
    func contentViewScrollViewDidScroll(_ scrollView: UIScrollView)
}

class ContentViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    var delegate: ContentViewControllerDelegate?
    
    // Dummy data for demonstration
    private let items = Array(0..<10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.identifier)
        
        
        //collectionView.contentInset = UIEdgeInsets(top: 380, left: 0, bottom: 0, right: 0)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else {
            return UICollectionViewCell()
        }
        // Configure cell if needed
        return cell
    }
}

extension ContentViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll: (x: \(scrollView.contentOffset.x), y: \(scrollView.contentOffset.y))")
        delegate?.contentViewScrollViewDidScroll(scrollView)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ContentViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ContentViewController {
        return ContentViewController()
    }
    func updateUIViewController(_ uiViewController: ContentViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
            .previewLayout(.sizeThatFits)
    }
}
#endif
