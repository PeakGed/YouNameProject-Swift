//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import SnapKit
import UIKit

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

class CenteringCollectionViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate
{
    private var collectionView: UICollectionView!
    private let items: [ItemSize] = (1...20).map { _ in
        ItemSize.allCases.randomElement()!
    }

    private enum ItemSize: Int, CaseIterable {
        case small = 0
        case medium = 1
        case large = 2
        
        var dimensions: (width: CGFloat, height: CGFloat) {
            switch self {
            case .small:
                return (50, 50)
            case .medium:
                return (100, 50)
            case .large:
                return (100, 100)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .white

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            
            // Calculate total width needed for current group
            let currentGroupItems = Array(self.items[sectionIndex * 3...(min(sectionIndex * 3 + 2, self.items.count - 1))])
            let totalWidth = currentGroupItems.reduce(0) { sum, item in
                sum + item.dimensions.width
            }
            let maxHeight = currentGroupItems.map { $0.dimensions.height }.max() ?? 100
            
            // Create items with their actual sizes
            let items = currentGroupItems.map { size in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(size.dimensions.width),
                    heightDimension: .absolute(size.dimensions.height)
                )
                return NSCollectionLayoutItem(layoutSize: itemSize)
            }
            
            // Create group with calculated dimensions
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(totalWidth + (CGFloat(items.count - 1) * 10)), // Add spacing between items
                heightDimension: .absolute(maxHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
            group.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 20
            
            // Center the content
            let containerWidth = layoutEnvironment.container.effectiveContentSize.width
            let inset = (containerWidth - groupSize.widthDimension.dimension) / 2
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: inset,
                bottom: 0, trailing: inset
            )
            
            return section
        }
    }

    // DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int
    {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .blue
        cell.layer.cornerRadius = 8
        
        // Use the pre-generated random size
        let sizeType = items[indexPath.item]
        
        return cell
    }
}

extension CenteringCollectionViewController: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(
//        _ scrollView: UIScrollView, withVelocity velocity: CGPoint,
//        targetContentOffset: UnsafeMutablePointer<CGPoint>
//    ) {
//        let proposedContentOffset = targetContentOffset.pointee.x
//        let cellWidthWithSpacing: CGFloat = 100 + 16  // Cell width + spacing
//        let index = round(proposedContentOffset / cellWidthWithSpacing)
//        let offset = index * cellWidthWithSpacing
//
//        targetContentOffset.pointee = CGPoint(x: offset, y: 0)
//    }
}
