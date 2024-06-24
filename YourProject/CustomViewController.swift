//
//  CustomViewController.swift
//  YourProject
//
//  Created by IntrodexMac on 17/5/2567 BE.
//

import Foundation
import UIKit
import SnapKit
import PagingKit

class CustomViewController: UIViewController {
 
    //topParallexView
    lazy var topParallexView: UIView = {
        let element = UIView()
        element.backgroundColor = .green
        return element
    }()
    
    lazy var menuViewController: PagingMenuViewController = {
        let element = PagingMenuViewController()
        element.dataSource = self
        element.delegate = self
        element.cellSpacing = 16
        element.contentInset = .init(top: 0,
                                     left: 20,
                                     bottom: 0,
                                     right: 20)
        element.register(type: MenuView.self,
                         forCellWithReuseIdentifier: "MenuView")
        element.view.backgroundColor = .blue
        
        return element
    }()

    lazy var contentViewController: PagingContentViewController = {
        let element = PagingContentViewController()
        element.delegate = self
        element.dataSource = self
        element.scrollView.bounces = true
        element.view.backgroundColor = .red
        return element
    }()
        
    lazy var vc1: MyCollectionView = {
        let element = MyCollectionView()
        element.delegate = self
        element.pageTitle = "Page 1"
        element.maxColItem = 50
        return element
    }()
        
    lazy var vc2: MyCollectionView = {
        let element = MyCollectionView()
        element.delegate = self
        element.pageTitle = "Page 2"
        element.maxColItem = 40
        return element
    }()
        
    lazy var vc3: MyCollectionView = {
        let element = MyCollectionView()
        element.delegate = self
        element.pageTitle = "Page 3"
        element.maxColItem = 30
        return element
    }()
    
    lazy var vc4: MyCollectionView = {
        let element = MyCollectionView()
        element.delegate = self
        element.pageTitle = "Page 4"
        element.maxColItem = 80
        return element
    }()
    
    lazy var vc5: MyCollectionView = {
        let element = MyCollectionView()
        element.delegate = self
        element.pageTitle = "Page 5"
        element.maxColItem = 100
        return element
    }()
    
    //var viewControllers: [UIViewController] = []
    var dataSource: [(menu: String, content: UIViewController)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initConstriantLayout()
        
        dataSource = [
            ("First", vc1),
            ("Second", vc2),
            ("Third", vc3),
            ("Fourth", vc4),
            ("Fifth", vc5)
        ]
        
        // call viewDidLoad on each dataSource.content
        dataSource.forEach { $0.content.viewDidLoad() }
        
        menuViewController.reloadData()
        //contentViewController.reloadData()
        
        // reload and cache all content viewcontroller
        dataSource.enumerated().forEach { ref in
            contentViewController.reloadData(with: ref.offset,
                                             completion: nil)
        }
        
    }
    
    private func initViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(contentViewController.view)
        self.view.addSubview(menuViewController.view)
        self.view.addSubview(topParallexView)
    }
    
    private func initConstriantLayout() {
        
        topParallexView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
       
        menuViewController.view.snp.makeConstraints { make in
            make.top.equalTo(topParallexView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        contentViewController.view.snp.makeConstraints { make in
            //make.top.equalTo(menuViewController.view.snp.bottom)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    // access to other vc in contentViewController and sync scrollView contentoffset
    func syncScrollOffsetY(offsetY: CGFloat) {
        
        dataSource.enumerated().forEach { index, _ in
            if let vc = dataSource[index].content as? MyCollectionView {
                //vc.collectionView.contentOffset.y = offsetY
                vc.scrollToContentOffsetYIfAble(offsetY: offsetY)
            }
        }
    }
}

extension CustomViewController: PagingMenuViewControllerDataSource {
    func menuViewController(viewController: PagingMenuViewController,
                            cellForItemAt index: Int) -> PagingMenuViewCell {
        //let typo = Styles.Typography.captionBold
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuView",
                                                      for: index) as! MenuView
        cell.titleLabel.textAlignment = .center
        cell.titleLabel.text = "index \(index)"
        return cell
    }

    func menuViewController(viewController: PagingMenuViewController,
                            widthForItemAt index: Int) -> CGFloat {
//        let width = OverlayMenuCell.sizingCell.calculateWidth(from: viewController.view.bounds.height,
//                                                              title: dataSource[index].menu,
//                                                              font: Styles.Typography.captionBold.properties.font)
        return 100
    }

    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
}

extension CustomViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }

    func contentViewController(viewController: PagingContentViewController,
                               viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension CustomViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController,
                            didSelect page: Int,
                            previousPage: Int) {
        print("menuViewController-didSelect page: \(page) | previousPage: \(previousPage)")
        contentViewController.scroll(to: page,
                                     animated: true)

//        if page != previousPage {
//            interactor.didSelectMenu(request: .init(index: page))
//        }
    }


    func menuViewController(viewController: PagingMenuViewController,
                            willAnimateFocusViewTo index: Int,
                            with coordinator: PagingMenuFocusViewAnimationCoordinator) {
//        print("menuViewController-willAnimateFocusViewTo index: \(index)")
//        viewController.visibleCells.compactMap { $0 as? OverlayMenuCell }.forEach { cell in
//            cell.updateMask()
//        }
//
//        coordinator.animateFocusView(alongside: { coordinator in
//            viewController.visibleCells.compactMap { $0 as? OverlayMenuCell }.forEach { cell in
//                cell.updateMask()
//            }
//        }) { _ in
//        }
    }

    func menuViewController(viewController: PagingMenuViewController,
                            willDisplay cell: PagingMenuViewCell,
                            forItemAt index: Int) {
        print("menuViewController-willDisplay: \(index)")
        //(cell as? OverlayMenuCell)?.updateMask()
    }
}

extension CustomViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController,
                               didManualScrollOn index: Int,
                               percent: CGFloat) {
//        guard !isMenuAtFirstIndexAndSwipeRight(didManualScrollOn: index,
//                                               percent: percent) else { return }
//        guard !isMenuAtLastIndexAndSwipeLeft(didManualScrollOn: index,
//                                             percent: percent) else { return }

        menuViewController.scroll(index: index,
                                  percent: percent,
                                  animated: false)
//        menuViewController.visibleCells.forEach {
//            guard let cell = $0 as? OverlayMenuCell else { return }
//            cell.updateMask()
//        }
    }

    func contentViewController(viewController: PagingContentViewController,
                               didEndManualScrollOn index: Int) {
//        guard interactor.currentMenuIndex != index else { return }
//        interactor.didSwipeChangeMenu(request: .init(index: index))
    }

    func contentViewController(viewController: PagingContentViewController,
                               willFinishPagingAt index: Int,
                               animated: Bool) {
        print("willFinishPagingAt: \(index) \(animated)")
    }

    func contentViewController(viewController: PagingContentViewController,
                               didFinishPagingAt index: Int,
                               animated: Bool) {
//        print("didFinishPagingAt: \(index) \(animated)")
//        guard interactor.currentMenuIndex != index else { return }
//        print("Menu Did change: \(interactor.currentMenuIndex) \(index)")
//        hapticMenuDidChange()
//        interactor.currentMenuIndex = index
//        reloadWebViewData(atIndex: index)
    }
}

extension CustomViewController: MyCollectionViewDelegate {
    
    func myCollectionViewDidScroll(_ scrollView: UIScrollView) {
        
        let minHeight: CGFloat = 50
        let maxHeight: CGFloat = 200
        
        // move topParallexView size up or down but limit minHeight at 100pt , maxHeight at 200pt
        let y = scrollView.contentOffset.y
        let topOffset: CGFloat = 244 // top offset of collectionView
        let diff = y + topOffset
        
        //let topParallexViewHeight = topParallexView.frame.height
        let changedHeight = maxHeight - diff
        
        print("y : \(y)")
        print("topOffset : \(topOffset)")
        print("diff : \(diff)")
        print("changedHeight : \(changedHeight)")
        
        if changedHeight <= minHeight {
            topParallexView.snp.updateConstraints { make in
                make.height.equalTo(minHeight)
            }
        }
        else if changedHeight > minHeight && changedHeight <= maxHeight {
            topParallexView.snp.updateConstraints { make in
                make.height.equalTo(changedHeight)
            }
        }
        else if changedHeight > maxHeight {
            topParallexView.snp.updateConstraints { make in
                make.height.equalTo(maxHeight)
            }
        }
        
        //let topViewHeight: CGFloat = min(max(minHeight, height), maxHeight)
        
        // access to other vc in contentViewController and sync scrollView contentoffset
        syncScrollOffsetY(offsetY: scrollView.contentOffset.y)
    }
    
    
}

extension UIColor {
    
    // random color
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
