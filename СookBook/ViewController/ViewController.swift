//
//  ViewController.swift
//  СookBook
//
//  Created by Alex on 26.02.2023.
//

import UIKit



final class ViewController: UIViewController {

    // MARK: - constant
    let secondViewController = UINavigationController()

    // MARK: - property
    
    let jumpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Press", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.tintColor = .systemGreen
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonPressed() {

        let secondViewController = TabBar()
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true, completion: nil)
        
     }

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addSubViews()
        configure()
        setConstraints()
    }

    // MARK: - flow funcs
    private func configure() {
        configureView()
        configureButton()
    }

    private func addSubViews() {
        view.addSubview(jumpButton)
    }

    private func configureView() {

    }

    

    private func configureButton() {

    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            jumpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jumpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

    // MARK: - extension Delegate
