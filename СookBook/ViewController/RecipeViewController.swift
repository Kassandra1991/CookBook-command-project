import UIKit

class RecipeViewController: UIViewController {

    // MARK: - property
    private let makeLabel = UILabel()
    private let recipeImageView = UIImageView()
    private var ingredientTableView = UITableView()

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        configure()
        setConstraints()
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        ingredientTableView.separatorStyle = .none
        ingredientTableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
        ingredientTableView.register(UINib(nibName: "IngredientHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "IngredientHeaderView")

        ingredientTableView.allowsMultipleSelection = true
    }

    // MARK: - flow funcs
    private func addSubViews() {
        view.addSubview(makeLabel)
        view.addSubview(recipeImageView)
        view.addSubview(ingredientTableView)
    }

    private func configure() {
        configureLabel()
        configureImageView()
        configureTableView()
        setConstraints()
    }

    private func configureLabel() {
        makeLabel.translatesAutoresizingMaskIntoConstraints = false
        makeLabel.text = "How to make french toast"
        makeLabel.textColor = .black
        makeLabel.font = UIFont.boldSystemFont(ofSize: 28)
        makeLabel.textAlignment = .left
        makeLabel.numberOfLines = 0
    }

    private func configureImageView() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.layer.masksToBounds = true
        recipeImageView.image = UIImage(named: "recipeImage")
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 12
    }

    private func configureTableView() {
        ingredientTableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            makeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            makeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            makeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            recipeImageView.topAnchor.constraint(equalTo: makeLabel.bottomAnchor, constant: 24),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),

            ingredientTableView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 24),
            ingredientTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ingredientTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ingredientTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - extension Delegate
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {

    public func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as! IngredientTableViewCell
        cell.selectionStyle = .none
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "IngredientHeaderView") as! IngredientHeaderView
        return header
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = (cell.isSelected) ? .checkmark : .none
    }
}
