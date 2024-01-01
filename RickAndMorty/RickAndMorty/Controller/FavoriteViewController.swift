//
//  FavoriteViewController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 01/01/2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemBlue
        let titleLabel = UILabel()
        titleLabel.text = "Favorites"
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel

    }
}
