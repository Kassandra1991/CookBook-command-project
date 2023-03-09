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
        static let descriptionImageViewSideSpacing: CGFloat = 29.0
        static let bookmarkImageViewSideSpacing: CGFloat = 37.0
        static let cellStackViewSideSpacing: CGFloat = 4.0
        static let cellStackViewLeftRightSpacing: CGFloat = 20.0
        static let bookmarkButtonSideSize: CGFloat = 24.0
        static let bookmarkButtonTopSpasing: CGFloat = 39.0
        static let bookmarkButtonTrailingSpasing: CGFloat = -20.0
        static let iconViewSideSpacing: CGFloat = 20.0
        static let descriptionStackViewWidth: CGFloat = 153.0
        static let numberOfLines: Int = 2
        static let widthIconImageView: CGFloat = 64.0
        static let bookmarkImageViewWidth: CGFloat = 24.0
        static let bookmarkImageViewHeight: CGFloat = 24.0
        static let descriptionStackViewSpacing: CGFloat = 8
        static let cellStackViewSpacing: CGFloat = 20
        static let paddingDescriptionStackView: CGFloat = 19
    }
    
    //MARK: - property
    
    var item: RecipeData!
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.cellStackViewSpacing
        stackView.backgroundColor = #colorLiteral(red: 0.9450981021, green: 0.9450981021, blue: 0.9450981021, alpha: 1)
        stackView.rounded()
        return stackView
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.descriptionStackViewSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var bookmarkView: UIView = {
        let view = UIView()
        return view
    }()
    
//    private let customAccessory = UICellAccessory.CustomViewConfiguration(customView: <#T##UIView#>, placement: <#T##UICellAccessory.Placement#>)
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .specialBlack
        //button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

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
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(icon)
        cellStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(titleLabel)
        descriptionStackView.addArrangedSubview(timeLabel)
        cellStackView.addArrangedSubview(bookmarkView)
        bookmarkView.addSubview(bookmarkButton)
        accessoryView = bookmarkView
    }
    
    //MARK: - flow funcs
    func configure(with item: RecipeData){
        self.item = item
        guard let imageName = item.results.first?.image,
              let title = item.results.first?.title,
              let time = item.results.first?.readyInMinutes
              //let status = item.isFavorite
        else { return }

        configureImage(with: imageName)
        configureTitle(with: title)
        configureTime(with: time)
        //configureHeartButton(status: status)
    }
//    func configureHeartButton(status: Bool) {
//        bookmarkButton.tintColor = status ? .specialPink : .specialBlack
//    }
    
    func configureImage(with name: String) {
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = UIImage(named: name)
    }

    func configureTitle(with text: String) {
        titleLabel.font = .poppinsBold14()
        titleLabel.numberOfLines = Constants.numberOfLines
        titleLabel.text = text
    }

    func configureTime(with time: Int) {
        timeLabel.text = "\(time) Mins"
        timeLabel.font = .poppinsRegular12()
        timeLabel.textColor = .specialLightGray
        timeLabel.contentMode = .left
    }
    
//    @objc private func favoriteButtonTapped(sender: UIButton) {
//        item.isFavorite?.toggle()
//        sender.tintColor = item.isFavorite! ? .specialPink : .specialBlack
//        print("Added to FAVORITE")
//    }
    
    func setConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.cellStackViewSideSpacing),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.cellStackViewLeftRightSpacing),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -Constants.cellStackViewLeftRightSpacing),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.cellStackViewSideSpacing),
        ])
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor, constant: Constants.iconViewSideSpacing),
            icon.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: Constants.widthIconImageView),
        ])
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            descriptionStackView.widthAnchor.constraint(equalToConstant: Constants.descriptionStackViewWidth),
            descriptionStackView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor),
            ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: descriptionStackView.topAnchor, constant: Constants.paddingDescriptionStackView),
            titleLabel.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: Constants.paddingDescriptionStackView),
            timeLabel.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        bookmarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkView.widthAnchor.constraint(equalToConstant: 44),
            bookmarkView.topAnchor.constraint(equalTo: cellStackView.topAnchor),
            bookmarkView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor),
            bookmarkView.trailingAnchor.constraint(equalTo: cellStackView.trailingAnchor)
            ])
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkButton.heightAnchor.constraint(equalToConstant: Constants.bookmarkButtonSideSize),
            bookmarkButton.widthAnchor.constraint(equalToConstant: Constants.bookmarkButtonSideSize),
            bookmarkButton.centerXAnchor.constraint(equalTo: bookmarkView.centerXAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: bookmarkView.centerYAnchor),
//            bookmarkButton.topAnchor.constraint(equalTo: bookmarkView.topAnchor, constant: Constants.bookmarkButtonTopSpasing),
//            bookmarkButton.leadingAnchor.constraint(equalTo: bookmarkView.leadingAnchor)
            ])
    }
}
