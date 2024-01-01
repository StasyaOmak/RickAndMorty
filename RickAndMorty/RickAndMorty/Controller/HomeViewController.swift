//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 01/01/2024.
//

import UIKit

class HomeViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Name or Episode (ex.S01E01)"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    private lazy var nameImage: UIImageView = {
        return createImageView(named: "logoImage", frame: CGRect(x: 45, y: 109, width: 300, height: 100))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         setupNavigationBar()
         view.addSubview(nameImage)
         view.addSubview(searchBar)

         setupConstraints()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemBlue
        let titleLabel = UILabel()
        titleLabel.text = "Episodes"
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel

        searchBar.delegate = self
    }

    private func updateSearchResults(for text: String?) {
        print("Search for: \(text ?? "")")
    }
}

private func createImageView(named imageName: String, frame: CGRect) -> UIImageView {
    let element = UIImageView()
    element.image = UIImage(named: imageName)
    element.contentMode = .scaleAspectFit
    element.frame = frame
    return element
}

extension HomeViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            searchBar.topAnchor.constraint(equalTo: nameImage.bottomAnchor, constant: 3),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        updateSearchResults(for: searchBar.text)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchText)
    }
}
