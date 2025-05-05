//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit
import Parchment

class CustomViewController: UIViewController {
    
    // Create a struct for our paging items
    struct Item: PagingItem, Hashable, Comparable {
        let index: Int
        let title: String
        
        static func < (lhs: Item, rhs: Item) -> Bool {
            return lhs.index < rhs.index
        }
    }
    
    // Create the PagingViewController
    lazy var pagingViewController: PagingViewController = {
        let pagingViewController = PagingViewController()
        pagingViewController.menuItemSize = .fixed(width: 100, height: 40)
        pagingViewController.textColor = .gray
        pagingViewController.selectedTextColor = .black
        pagingViewController.indicatorColor = .black
        pagingViewController.indicatorOptions = .visible(
            height: 2,
            zIndex: Int.max,
            spacing: .zero,
            insets: .zero
        )
        pagingViewController.collectionView.isScrollEnabled = false
        return pagingViewController
    }()
    
    // Create view controllers for each category
    lazy var categoryViewControllers: [UIViewController] = {
        return [
            createCategoryViewController(title: "Category 1"),
            createCategoryViewController(title: "Category 2"),
            createCategoryViewController(title: "Category 3")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        // Add the paging view controller as a child
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        // Set the data source
        pagingViewController.dataSource = self
    }
    
    private func initConstriantLayout() {
        pagingViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Helper function to create category view controllers
    private func createCategoryViewController(title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        viewController.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return viewController
    }
}

// MARK: - PagingViewControllerDataSource
extension CustomViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return categoryViewControllers.count
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return categoryViewControllers[index]
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return Item(index: index, title: "Cate \(index + 1)")
    }
}
