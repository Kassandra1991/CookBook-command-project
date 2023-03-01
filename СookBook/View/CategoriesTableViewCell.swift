//
//  CategoriesTableViewCell.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-03-01.
//

import UIKit

final class CategoriesViewCell: UICollectionViewCell {

    //MARK: - var\let
    let view = UIView()
    let label = UILabel()

    //MARK: - flow funcs
    func configure(with name: String) {
        view.addSubview(label)
        contentView.addSubview(view)

        label.text = name
        label.textAlignment = .center
        label.textColor = .red

        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        setConstraint()
    }

    func setConstraint() {
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func didSelectItem() {
        view.backgroundColor = .red
        label.textColor = .white
    }

    func didDeselectItem() {
        view.backgroundColor = .white
        label.textColor = .red
    }
}

