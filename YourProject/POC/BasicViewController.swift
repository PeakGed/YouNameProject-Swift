//import Parchment
//import UIKit
//
//// This is the simplest use case of using Parchment. We just create a
//// bunch of view controllers, and pass them into our paging view
//// controller. FixedPagingViewController is a subclass of
//// PagingViewController that makes it much easier to get started with
//// Parchment when you only have a fixed array of view controllers. It
//// will create a data source for us and set up the paging items to
//// display the view controllers title.
//class BasicViewController: UIViewController {
//   
//    
//    typealias Group = CustomContentViewController.Group
//    
//    private let groups: [Group] = [
//        Group(title: "Group 1", items: ["Item 1", "Item 2", "Item 3" , "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9"]),
//        Group(title: "Group 2", items: ["Item 10", "Item 11", "Item 12", "Item 13", "Item 14", "Item 15", "Item 16", "Item 17", "Item 18"]),
//        Group(title: "Group 3", items: ["Item 19", "Item 20", "Item 21", "Item 22", "Item 23", "Item 24", "Item 25", "Item 26", "Item 27"])
//    ]
//    
//    
//    
//    var vcs: [UIViewController] = []
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let viewControllers = [
//            CustomContentViewController(index: 0, group: groups[0]),
//            CustomContentViewController(index: 1, group: groups[1]),
//            CustomContentViewController(index: 2, group: groups[2])
//        ]
////        vcs = [
////            CustomContentViewController(index: 0, group: groups[0]),
////            CustomContentViewController(index: 1, group: groups[1]),
////            CustomContentViewController(index: 2, group: groups[2])
////        ]
//        
//
//        let pagingViewController = PagingViewController(viewControllers: viewControllers)
//        //pagingViewController.collectionView.isScrollEnabled = false
//        //pagingViewController.collectionView.panGestureRecognizer.isEnabled = false
//        //pagingViewController.dataSource = self
//
//        // Make sure you add the PagingViewController as a child view
//        // controller and constrain it to the edges of the view.
//        addChild(pagingViewController)
//        view.addSubview(pagingViewController.view)
//        view.constrainToEdges(pagingViewController.view)
//        pagingViewController.didMove(toParent: self)
//    }
//    
////    func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
////        3
////    }
////    
////    func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
////        vcs[0]
////    }
////    
////    func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> any Parchment.PagingItem {
////        return PagingItemX(0)
////    }
////    
//}
//
//struct PagingItemX: PagingItem {
//    var identifier: Int
//    
//    init (_ id: Int) {
//        self.identifier = id
//    }
//    
//    func isEqual(to item: PagingItem) -> Bool {
//        item.identifier == identifier
//    }
//    
//    func isBefore(item: PagingItem) -> Bool {
//        identifier < item.identifier
//    }
//}
////
////extension BasicViewController: PageViewControllerDataSource {
////
////    
////}
//
//final class CustomContentViewController: UIViewController {
//    
//    struct Group {
//        let id: UUID = .init()
//        let title: String
//        let items: [String]
//    }
//    var group: Group
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 10 // Set to 0 to prevent vertical stacking
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        layout.estimatedItemSize = .zero // Don't use estimated size
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
//        collectionView.register(CollectionFooterView.self, 
//                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//                              withReuseIdentifier: CollectionFooterView.identifier)
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.alwaysBounceHorizontal = true
//        return collectionView
//    }()
//    
//    convenience init(index: Int, group: Group) {
//        self.init(title: "View \(index)", content: "\(index)",group: group)
//    }
//
//    convenience init(title: String, group: Group) {
//        self.init(title: title, content: title, group: group)
//    }
//
//    init(title: String, content: String, group: Group) {
//        self.group = group
//        super.init(nibName: nil, bundle: nil)
//        self.title = title
//        //self.group = group
//        setupUI()
//    }
//
//    required init?(coder _: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .white
//        view.addSubview(collectionView)
//        
//        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(60) // Fixed height for single row
//        }
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//extension CustomContentViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return group.items.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.titleLabel.text = group.items[indexPath.item]
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionFooter {
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                       withReuseIdentifier: CollectionFooterView.identifier,
//                                                                       for: indexPath) as! CollectionFooterView
//            return footer
//        }
//        return UICollectionReusableView()
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension CustomContentViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = group.items[indexPath.item]
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 16)
//        label.text = text
//        let width = label.intrinsicContentSize.width + 32 // Add padding
//        return CGSize(width: width, height: 40)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 80, height: collectionView.bounds.height)
//    }
//}
//
//class CustomCollectionViewCell: UICollectionViewCell {
//    static let identifier = "CustomCollectionViewCell"
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = .systemFont(ofSize: 16)
//        label.numberOfLines = 1
//        label.lineBreakMode = .byWordWrapping
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override var intrinsicContentSize: CGSize {
//        let sizeThatFits = titleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 40))
//        return CGSize(width: ceil(sizeThatFits.width) + 16, height: 40) // Add padding
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(titleLabel)
//        contentView.backgroundColor = .white
//        
//        titleLabel.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(8)
//        }
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        titleLabel.text = nil
//    }
//}
//
//// Add the FooterView class
//class CollectionFooterView: UICollectionReusableView {
//    static let identifier = "CollectionFooterView"
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "next page"
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = .systemFont(ofSize: 14)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        backgroundColor = .systemGray5
//        addSubview(titleLabel)
//        
//        titleLabel.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//    }
//}
//
