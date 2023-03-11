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
        static let trendViewSideSpacing: CGFloat = 20.0
        static let trendViewHeight: CGFloat = 28.0
        static let numberOfLines: Int = 2
        static let widthSearchImageView: CGFloat = 20.0
        static let heightSearchImageView: CGFloat = 20.0
        static let heightForRow: CGFloat = 104.0
        static let mainStackViewSpacing: CGFloat = 0
    }
    
    // MARK: - property
    
    var networkManager = NetworkManager()
    
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
    
    private lazy var trendView: UIView = {
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
    
    private var recipies: RecipeData?
    
    private let items: [Item] = [
    Item(id: 0, title: "Papper ramen", category: "Noodle", image: "ramen", bookmark: "bookmark", time: 10, isFavorite: false),
    Item(id: 1, title: "Sweet souse noodle", category: "Lunch", image: "ramen2", bookmark: "bookmark", time: 15, isFavorite: false),
    Item(id: 2, title: "Chicken soup", category: "Noodle", image: "ramen3", bookmark: "bookmark", time: 19, isFavorite: false),
    Item(id: 3, title: "Sweet cqke with jam", category: "Desert", image: "ramen2", bookmark: "bookmark", time: 35, isFavorite: false),
    Item(id: 4, title: "Sweet soupe", category: "Lunch", image: "ramen2", bookmark: "bookmark", time: 25, isFavorite: false),
    ]
    
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
                            tabBarItem.selectedImage = UIImage(systemName: "house.fill")
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
        mainStackView.addArrangedSubview(searchView)
        searchView.addSubview(searchTextField)
        mainStackView.addArrangedSubview(trendView)
        trendView.addSubview(titleTrendLabel)
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
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor)
        ])
        trendView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            trendView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.trendViewSideSpacing),
            trendView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Constants.trendViewSideSpacing),
            trendView.heightAnchor.constraint(equalToConstant: Constants.trendViewHeight),
        ])
        titleTrendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTrendLabel.topAnchor.constraint(equalTo: trendView.topAnchor),
            titleTrendLabel.leadingAnchor.constraint(equalTo: trendView.leadingAnchor),
            titleTrendLabel.trailingAnchor.constraint(equalTo: trendView.trailingAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: trendView.bottomAnchor),
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
        cell.configure(with: recipies!.results[indexPath.row])
        cell.tintColor = .specialBlack
        cell.selectionStyle = .none
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let сontroller = RecipeViewController()
        сontroller.makeLabel.text = items[indexPath.row].title
        сontroller.recipeImageView.image = UIImage(named: items[indexPath.row].image ?? "ramen")
        present(сontroller, animated: true, completion: nil)
        print("Cell at \(indexPath.row) row tapped!")
    }
}


extension MainViewController: NetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        recipies = dataFromApi
        print(recipies?.results.first?.image)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}
