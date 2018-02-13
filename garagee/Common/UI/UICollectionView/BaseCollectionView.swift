//
//  BaseCollectionView.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//
import RxCocoa
import RxDataSources
import RxSwift
import RxViewModel
import UIKit

class BaseCollectionView<VM: BaseViewModel>: BaseViewController<VM>, ReusableCollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	var dataSource = RxCollectionViewSectionedReloadDataSource<BaseSectionModel>(configureCell: BaseCollectionView.configureCellFactory(ForSectionModelType: BaseSectionModel.self))

    let refresher = UIRefreshControl()
    var bottomButtonOffset: Bool = false

    var collectionView: UICollectionView! = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var cellClasses: [UICollectionViewCell.Type] { return [] }

    var headerClasses: [UICollectionReusableView.Type] {
        return []
    }

    var footerClasses: [UICollectionReusableView.Type] {
        return []
    }

    override init(viewModel: VM, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(viewModel: viewModel)
        self.view.insertSubview(collectionView, at: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//		collectionView!.addSubview(refresher)

        self.view.addConstraints([
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.delaysContentTouches = false
        self.registerCells()
        self.registerHeaders()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.keyboardDismissMode = .interactive
        self.setupRx()
        super.viewDidLoad()
		self.collectionView.backgroundColor = UIColor.groupTableViewBackground
    }

    func setupRx() {
        // Cell configuration
        self.dataSource.configureCell =
			type(of: self).configureCellFactory(ForSectionModelType: BaseSectionModel.self)
		self.dataSource.configureSupplementaryView = type(of: self).supplementaryViewFactory(ForSectionModelType: BaseSectionModel.self, RowsIndexesWithTitle: [])

    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var cell = (cell as! Cell)
        cell.isPresented = true
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var cell = (cell as! Cell)
        cell.isPresented = false
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 55)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
