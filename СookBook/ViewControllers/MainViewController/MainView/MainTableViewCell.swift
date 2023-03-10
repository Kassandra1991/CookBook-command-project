//
//  MainTableViewCell.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-28.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // MARK: - constants
    enum Constants {
//        static let descriptionImageViewSideSpacing: CGFloat = 29.0
//        static let bookmarkImageViewSideSpacing: CGFloat = 37.0
//        static let cellStackViewSideSpacing: CGFloat = 4.0
//        static let cellStackViewLeftRightSpacing: CGFloat = 20.0
//        static let bookmarkButtonSideSize: CGFloat = 24.0
//        static let bookmarkButtonTopSpasing: CGFloat = 39.0
//        static let bookmarkButtonTrailingSpasing: CGFloat = -20.0
//        static let iconViewSideSpacing: CGFloat = 20.0
//        static let descriptionStackViewWidth: CGFloat = 153.0
//        static let numberOfLines: Int = 2
//        static let widthIconImageView: CGFloat = 64.0
//        static let bookmarkImageViewWidth: CGFloat = 24.0
//        static let bookmarkImageViewHeight: CGFloat = 24.0
//        static let descriptionStackViewSpacing: CGFloat = 8
//        static let cellStackViewSpacing: CGFloat = 20
//        static let paddingDescriptionStackView: CGFloat = 19
    }
    
    //MARK: - property
    
    var item: RecipeData.RecipeDescription!
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .specialBlack
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
//    private let customAccessory = UICellAccessory.CustomViewConfiguration(customView: UIImageView(image: UIImage(systemName: "heart.fill")), placement: .trailing(displayed: .always))

    //MARK: - lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(heartButton)
        contentView.backgroundColor = .specialGray
    }
    
    //MARK: - flow funcs
    func configure(with item: RecipeData.RecipeDescription){
        self.item = item
        guard let imageName = item.image
              //let status = item.isFavorite
        else { return }

        configureImage(with: imageName)
        configureTitle(with: item.title)
        configureTime(with: item.readyInMinutes)
        //configureHeartButton(status: status)
    }
//    func configureHeartButton(status: Bool) {
//        bookmarkButton.tintColor = status ? .specialPink : .specialBlack
//    }
    
    func configureImage(with name: String) {
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = UIImage(named: "ramen")//name)
    }

    func configureTitle(with text: String?) {
        titleLabel.font = .poppinsBold14()
        titleLabel.numberOfLines = 0
        titleLabel.text = text
    }

    func configureTime(with time: Int?) {
        timeLabel.text = "\(time ?? .zero) Mins"
        timeLabel.font = .poppinsRegular12()
        timeLabel.textColor = .specialLightGray
        timeLabel.contentMode = .left
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
//        item.isFavorite?.toggle()
//        sender.tintColor = item.isFavorite! ? .specialPink : .specialBlack
        sender.tintColor = .specialPink
        print("Added to FAVORITE")
    }
    
    func setConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: 64),
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 175),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            timeLabel.widthAnchor.constraint(equalToConstant: 175),
            timeLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
        ])
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24),
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39)
            ])
    }
}
