//
//  ViewController.swift
//  lesson 4 Collection
//
//  Created by Alexander Myskin on 10.04.2022.
//

import UIKit

class ViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<HeadModel, Items>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HeadModel, Items>

    let cellHeight: CGFloat = 80.0
    let headHeight: CGFloat = 32.0
    let screenSize: CGRect = UIScreen.main.bounds

    private let cellReuseIdentifier = "Cell"
    private let sectionReuseIdentifier = "Section"

    private lazy var datasource = makeDataSource()
    private var snapshot = Snapshot()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        return UICollectionView(frame: screenSize, collectionViewLayout: flowLayout)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()

        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(
            HeadCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: sectionReuseIdentifier)
        collectionView.delegate = self
    }

    private func configureUI() {
        title = "Collection"

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: - private Functions
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) ->
                CustomCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.cellReuseIdentifier,
                    for: indexPath) as? CustomCell
                cell?.title.text = item.title
                cell?.label.text = item.label
                return cell
            })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.datasource.snapshot()
                .sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: self.sectionReuseIdentifier,
                for: indexPath) as? HeadCell
            view?.title.text = section.title
            return view
        }
        return dataSource
    }

    private func fetchData() {
        snapshot = Snapshot()
        let sections = DummyData.makeDummyHead()
        snapshot.appendSections(sections)
        sections.forEach { headModel in
            let items = DummyData.makeDummyItems()
            snapshot.appendItems(items, toSection: headModel)
        }
        datasource.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: screenSize.width - 32, height: cellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = datasource.sectionIdentifier(for: section)
        let title = section?.title ?? ""
        let height: CGFloat = title.isEmpty ? 0 : headHeight
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let selectedItem = datasource.itemIdentifier(for: indexPath)
        else {
            return
        }
        print(selectedItem)
    }
}
