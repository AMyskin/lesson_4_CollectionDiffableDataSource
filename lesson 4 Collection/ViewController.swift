//
//  ViewController.swift
//  lesson 4 Collection
//
//  Created by Alexander Myskin on 10.04.2022.
//

import UIKit

class ViewController: UIViewController,
                      UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout,
                      UICollectionViewDelegate {

    let cellHeight: CGFloat = 80.0
    let headHeight: CGFloat = 32.0
    let screenSize: CGRect = UIScreen.main.bounds

    private let cellReuseIdentifier = "Cell"

    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        return UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
    }()

    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var section = ["A", "B", "C"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.register(
            HeadCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "Section")
        collectionView.delegate = self
        collectionView.dataSource = self
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

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        section.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor.green
        cell.title.text = "Title \(indexPath.row)"
        cell.label.text = items[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                            viewForSupplementaryElementOfKind kind: String,
                            at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath) as! HeadCell

        view.title.text = "Заголовок секции \(indexPath.section + 1) = \(section[indexPath.section])"
        view.backgroundColor = .red
        return view
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: headHeight)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: screenSize.width - 32, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("нажата ячейка No \(indexPath.row) в секции \(indexPath.section)")
    }
}

