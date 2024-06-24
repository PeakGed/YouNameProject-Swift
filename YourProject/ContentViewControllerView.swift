//
//  ContentViewControllerView.swift
//  YourProject
//
//  Created by IntrodexMac on 24/6/2567 BE.
//

import Foundation
import UIKit


protocol MyCollectionViewDelegate {
 
    func myCollectionViewDidScroll(_ scrollView: UIScrollView)
    
}

class MyCollectionView: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        let width = UIScreen.main.bounds.width
        layout.itemSize = .init(width: width,
                                height: 200)
        
        let element = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout)
        element.backgroundColor = .white
        element.delegate = self
        element.dataSource = self
        element.register(MyCollectionViewCell.self,
                         forCellWithReuseIdentifier: "MyCollectionViewCell")
        
        element.contentInset = .init(top: 244,
                                     left: 0,
                                     bottom: 0,
                                     right: 0)
        return element
    }()
    
    var delegate: MyCollectionViewDelegate?
    
    var pageTitle: String = ""
    var maxColItem: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
    }
    
    private func initConstriantLayout() {
        collectionView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func update(maxColItem: Int) {
        self.maxColItem = max(0, maxColItem)
        
        collectionView.reloadData()
    }
    
    func scrollToContentOffsetYIfAble(offsetY: CGFloat) {     
        //guard offsetY > 0 else { return }
        
        let maxOffsetY = collectionView.contentSize.height
        let maxHeight: CGFloat = CGFloat(maxColItem) * 100.0
        
        switch offsetY {
        case ..<0:
            collectionView.contentOffset.y = offsetY
        case 1...maxHeight:
            print("pageTitle: \(pageTitle)")
            print("maxOffsetY: \(maxOffsetY)")
            print("offsetY: \(offsetY)")
            collectionView.contentOffset.y = offsetY
        default:
            break
            //collectionView.contentOffset.y = maxOffsetY
        }
//        
//        if offsetY <= maxOffsetY {
//            print("pageTitle: \(pageTitle)")
//            print("maxOffsetY: \(maxOffsetY)")
//            print("offsetY: \(offsetY)")
//            collectionView.contentOffset.y = maxOffsetY
//            return
//        }
//        
//        let y = min(offsetY, maxOffsetY)
//        
//        collectionView.contentOffset.y = y
    }
}

// init collectionview compositional layout
private extension MyCollectionView {
    
    func initCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0,
                                       leading: 16,
                                       bottom: 0,
                                       trailing: 16)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0,
                                          leading: 0,
                                          bottom: 0,
                                          trailing: 0)
            
            return section
        }
        
        collectionView.collectionViewLayout = layout
    }
}


extension MyCollectionView: UICollectionViewDelegate {
    
}

extension MyCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return maxColItem
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell",
                                                      for: indexPath) as! MyCollectionViewCell
        //random background color
        cell.backgroundColor = .random()
        cell.titleLabel.text = "Hello World \(indexPath.row)"
        
        return cell
    }
}

extension MyCollectionView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.myCollectionViewDidScroll(scrollView)
    }
}


class MyCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.text = "Hello World"
        
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
    
    
}


// MARK: - Layout
private extension MyCollectionViewCell {
    
    func initViews() {
        self.backgroundColor = .white
        
        self.contentView.addSubview(titleLabel)
    }
    
    func initConstriantLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
}

