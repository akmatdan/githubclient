//
//  MainViewController.swift
//  githubclient
//
//  Created by Daniil Akmatov on 19/6/23.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let myRepositoriesButton = UIButton(type: .system)
        myRepositoriesButton.setTitle("My repositories", for: .normal)
        myRepositoriesButton.addTarget(self, action: #selector(didTapMyRepositories), for: .touchUpInside)
        myRepositoriesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myRepositoriesButton)
        
        let myProfileButton = UIButton(type: .system)
        myProfileButton.setTitle("My profile", for: .normal)
        myProfileButton.addTarget(self, action: #selector(didTapMyProfile), for: .touchUpInside)
        myProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myProfileButton)
        
        NSLayoutConstraint.activate([
            myRepositoriesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myRepositoriesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            myProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myProfileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }
    
    @objc private func didTapMyRepositories() {
        let myRepositoriesViewController = MyRepositoriesViewController()
        navigationController?.pushViewController(myRepositoriesViewController, animated: true)
    }
    
    @objc private func didTapMyProfile() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
