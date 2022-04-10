//
//  HeadCell.swift
//  lesson 4 Collection
//
//  Created by Alexander Myskin on 10.04.2022.
//

import UIKit

class HeadCell: UICollectionViewCell {
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        title.translatesAutoresizingMaskIntoConstraints = false

        addSubview(title)
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
