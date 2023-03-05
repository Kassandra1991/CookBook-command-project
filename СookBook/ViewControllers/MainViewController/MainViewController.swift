//
//  MainViewController.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-27.

import UIKit

class MainViewController: UIViewController {

    // MARK: - constants
    enum Constants {
        static let receipeLabel: String = "Find best recipes for cooking"
        static let searchTextFieldLabel: String = "Search recepies"
        static let trendLabel: String = "Trending now 🔥"
        static let bookmarkImage: String = "heart"
        static let searchImage: String = "search"
        static let tableViewSideSpacing: CGFloat = 20.0
        static let searchViewSideSpacing: CGFloat = 20.0
        static let searchViewHeight: CGFloat = 60.0
        static let topViewViewSideSpacing: CGFloat = 20.0
        static let topViewViewHeight: CGFloat = 98.0
        static let numberOfLines: Int = 2
        static let widthSearchImageView: CGFloat = 20.0
        static let heightSearchImageView: CGFloat = 20.0
        static let heightForRow: CGFloat = 104.0
        static let mainStackViewSpacing: CGFloat = 0
    }
    
    // MARK: - property
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.mainStackViewSpacing
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var receipeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLines
        label.text = Constants.receipeLabel
        label.font = .poppinsBold24()
        return label
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.widthSearchImageView, height: Constants.heightSearchImageView))
        imageView.image = UIImage(named: Constants.searchImage)
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = Constants.searchTextFieldLabel
        tf.borderStyle = .roundedRect
        tf.leftViewMode = .always
        tf.leftView = searchImageView
        return tf
    }()
    
    let titleTrendLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.trendLabel
        label.font = .poppinsBold20()
        label.numberOfLines = Constants.numberOfLines
        label.sizeToFit()
        label.textColor = UIColor.specialBlack
        return label
       }()
    
    private lazy var bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.bookmarkImage)
        return imageView
    }()
    
    private let items: [Item] = [
    Item(id: 0, title: "Papper ramen", category: "Noodle", image: "ramen", bookmark: "bookmark", time: 10, isFavorite: false),
    Item(id: 1, title: "Sweet souse noodle", category: "Lunch", image: "ramen2", bookmark: "bookmark", time: 15, isFavorite: false),
    Item(id: 2, title: "Chicken soup", category: "Noodle", image: "ramen3", bookmark: "bookmark", time: 19, isFavorite: false)
    ]
    
    private lazy var tableView = UITableView()
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
// MARK: - flow funcs
    private func configure() {
        configureView()
        configureTableView()
    }
    
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        topView.addSubview(receipeLabel)
        mainStackView.addArrangedSubview(searchView)
        searchView.addSubview(searchTextField)
        mainStackView.addArrangedSubview(tableView)
    }
    
    func configureView() {
        view.backgroundColor = UIColor.white
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = titleTrendLabel
    }
    
    private func setConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.topViewViewSideSpacing),
            topView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Constants.topViewViewSideSpacing),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewViewHeight),
        ])
        receipeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receipeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            receipeLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            receipeLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            receipeLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.searchViewSideSpacing),
            searchView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Constants.searchViewSideSpacing),
            searchView.heightAnchor.constraint(equalToConstant: Constants.searchViewHeight),
        ])
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.tableViewSideSpacing),
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Constants.tableViewSideSpacing)
        ])
    }
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.configure(with: items[indexPath.row])
        return  cell
    }
}
