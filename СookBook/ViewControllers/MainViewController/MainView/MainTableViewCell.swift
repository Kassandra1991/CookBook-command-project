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
        static let iconViewSideSpacing: CGFloat = 20.0
        static let descriptionStackViewWidth: CGFloat = 153.0
        static let numberOfLines: Int = 2
        static let widthIconImageView: CGFloat = 64.0
        static let bookmarkImageViewWidth: CGFloat = 24.0
        static let bookmarkImageViewHeight: CGFloat = 24.0
        static let descriptionStackViewSpacing: CGFloat = 8
        static let cellStackViewSpacing: CGFloat = 20
    }
    
    //MARK: - property
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
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
    
    private lazy var bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        cellStackView.addArrangedSubview(bookmarkImageView)
    }
    
    //MARK: - flow funcs
    func configure(with item: Item){
        guard let imageName = item.image,
              let title = item.title,
              let time = item.time,
              let bookmark = item.bookmark else { return }

        configureImage(with: imageName)
        configureTitle(with: title)
        configureTime(with: time)
        configureBookmark(with: bookmark)
    }
    
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
    
    func configureBookmark(with name: String) {
        bookmarkImageView.contentMode = .scaleAspectFill
        bookmarkImageView.clipsToBounds = true
        bookmarkImageView.image = UIImage(named: name)
    }
    
    func setConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.cellStackViewSideSpacing),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.cellStackViewSideSpacing),
        ])
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor, constant: Constants.iconViewSideSpacing),
            icon.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: Constants.iconViewSideSpacing),
            icon.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -Constants.iconViewSideSpacing),
            icon.widthAnchor.constraint(equalToConstant: Constants.widthIconImageView),
        ])
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionStackView.widthAnchor.constraint(equalToConstant: Constants.descriptionStackViewWidth),
            descriptionStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: Constants.descriptionStackViewSpacing),
            descriptionStackView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -Constants.descriptionStackViewSpacing),

            ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkImageView.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: Constants.bookmarkImageViewSideSpacing),
            bookmarkImageView.leadingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor, constant: 20),
            bookmarkImageView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -Constants.bookmarkImageViewSideSpacing),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: Constants.bookmarkImageViewWidth),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: Constants.bookmarkImageViewHeight),
        ])
    }
}
