//
//  StartViewController.swift
//  СookBook
//
//  Created by Dmitriy Babichev on 27.02.2023.
//

import UIKit

class StartViewController: UIViewController {

    private let backgroundImage = UIImageView()
    private let letsCookingLabel = UILabel()
    private let findRecipesLabel = UILabel()
    private let startCookingButton = UIButton(type: .system)
    private let darkOverlay = UIView()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        [letsCookingLabel, findRecipesLabel, startCookingButton ].forEach({ stack.addArrangedSubview($0) })
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTargets()
    }

    func setupUI() {
        // MARK: Backgorund Image
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "background_launchscreen")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)

        // MARK: Dark Overlay
        darkOverlay.translatesAutoresizingMaskIntoConstraints = false
        darkOverlay.backgroundColor = .black
        darkOverlay.alpha = 0.18
        view.addSubview(darkOverlay)

        // MARK: Let's Cooking Label
        letsCookingLabel.numberOfLines = 0
        letsCookingLabel.text = "Let's Cooking"
        letsCookingLabel.textAlignment = .center
        letsCookingLabel.font = .systemFont(ofSize: 60, weight: .heavy)
        letsCookingLabel.textColor = .white

        // MARK: Find Recipes Label
        findRecipesLabel.text = "Find best recipes for cooking"
        findRecipesLabel.font = .preferredFont(forTextStyle: .body)
        findRecipesLabel.textColor = .white

        // MARK: Start Cooking Button
        startCookingButton.setTitle("Start cooking", for: .normal)
        startCookingButton.setTitleColor(.white, for: .normal)
        startCookingButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        startCookingButton.backgroundColor = .systemPink
        startCookingButton.layer.cornerRadius = 10

        view.addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            // MARK: Background Image
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // MARK: Dark Overlay
            darkOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            darkOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            darkOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // MARK: Start Cooking Button
            startCookingButton.widthAnchor.constraint(equalToConstant: 200),
            startCookingButton.heightAnchor.constraint(equalToConstant: 50),

            // MARK: StackView
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3)
        ])
    }

    func setupTargets() {
        startCookingButton.addTarget(self, action: #selector(startCookingButtonDidTapped), for: .touchUpInside)
    }

    @objc private func startCookingButtonDidTapped() {
        // TODO: transition to the next VC
        let secondVC = ViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
