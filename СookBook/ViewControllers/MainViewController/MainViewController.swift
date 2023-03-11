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
        static let tabBarImage: String = "house.fill"
        static let topViewSideSpacing: CGFloat = 20.0
        static let receipeLabelHeight: CGFloat = 58.0
        static let searchTFTopSpacing: CGFloat = 28.0
        static let searchTFHeight: CGFloat = 44.0
        static let topViewHeight: CGFloat = 198.0
        static let trendTitleTopSpacing: CGFloat = 20.0
        static let tableViewTopSpacing: CGFloat = 20.0
        static let trendViewHeight: CGFloat = 28.0
        static let numberOfLines: Int = 2
        static let heightForRow: CGFloat = 104.0
        static let searchImageViewSide: CGFloat = 20.0
    }
    
    // MARK: - property
    
    var networkManager = NetworkManager()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var topView: UIView = {
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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.searchImageViewSide, height: Constants.searchImageViewSide))
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
    
    private var recipies: RecipeData?
    
    private lazy var tableView = UITableView()
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        setConstraints()
        networkManager.delegate = self
        networkManager.getRecipes(.random)
        if let tabBarItem = self.tabBarController?.tabBar.items?[0] {   // Change the image of the active picture tabBar
            tabBarItem.selectedImage = UIImage(systemName: Constants.tabBarImage)
                        }
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
        topView.addSubview(searchTextField)
        topView.addSubview(titleTrendLabel)
        mainStackView.addArrangedSubview(tableView)
    }
    
    func configureView() {
        view.backgroundColor = UIColor.white
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .clear
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
            topView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.topViewSideSpacing),
            topView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Constants.topViewSideSpacing),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
        ])
        receipeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receipeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            receipeLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            receipeLabel.heightAnchor.constraint(equalToConstant: Constants.receipeLabelHeight),
            receipeLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor)
        ])
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: receipeLabel.bottomAnchor, constant: Constants.searchTFTopSpacing),
            searchTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.searchTFHeight)
        ])
        titleTrendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTrendLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constants.trendTitleTopSpacing),
            titleTrendLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            titleTrendLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            titleTrendLabel.heightAnchor.constraint(equalToConstant: Constants.trendViewHeight)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Constants.tableViewTopSpacing),
            tableView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counting = recipies?.results.count else {
            return 0
        }
        return counting
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        guard let recipies = recipies?.results else {
            return MainTableViewCell()
        }
        cell.configure(with: (recipies[indexPath.row]))
        let item = recipies[indexPath.row].image
        let url = URL(string: item ?? "")
        cell.icon.kf.setImage(with: url)
        cell.tintColor = .specialBlack
        cell.selectionStyle = .none
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let сontroller = RecipeViewController()
        let item = recipies?.results[indexPath.row]
        сontroller.makeLabel.text = item?.title
        сontroller.recipeId = item?.id ?? 0
        let url = URL(string: item?.image ?? "")
        сontroller.recipeImageView.kf.setImage(with: url)
        present(сontroller, animated: true, completion: nil)
    }
}

extension MainViewController: NetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        recipies = dataFromApi
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}
