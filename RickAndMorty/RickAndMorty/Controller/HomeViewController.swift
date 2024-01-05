//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 01/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var episods: [EpisodModel] = []
    private let episodNetworkManager = EpisodNetworkManager()
    private var descriptionModel: [DescriptionModel] = []
    private var characterModel: [CharacterModel] = []
    
    private let sectionInsert = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    let searchBar = SearchView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    private lazy var nameImage: UIImageView = {
        return createImageView(named: "logoImage", frame: CGRect(x: 45, y: 109, width: 300, height: 100))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(filterButton)
        setupNavigationBar()
        setupCollectionView()
        view.addSubview(nameImage)
        view.addSubview(searchBar)
        
        setupConstraints()
        fetchData()
        
    }
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0.89, green: 0.95, blue: 0.99, alpha: 1.00)
        button.layer.cornerRadius = 8.0
        let titleColor = UIColor(red: 0.29, green: 0.65, blue: 0.96, alpha: 1.00)
        let attributedTitle = NSAttributedString(string: "ADVANCED FILTERS", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: button.titleLabel?.font.pointSize ?? 17.0), NSAttributedString.Key.foregroundColor: titleColor])
        button.setAttributedTitle(attributedTitle, for: .normal)

        if let image = UIImage(systemName: "line.3.horizontal.decrease") {
            let grayImage = image.withTintColor(.gray)
            button.setImage(grayImage, for: .normal)
        }
        button.imageView?.tintColor = .gray
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 15).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemBlue
        let titleLabel = UILabel()
        titleLabel.text = "Episodes"
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel

    }
    
    private func updateSearchResults(for text: String?) {
        print("Search for: \(text ?? "")")
    }
    
    
    private func createImageView(named imageName: String, frame: CGRect) -> UIImageView {
        let element = UIImageView()
        element.image = UIImage(named: imageName)
        element.contentMode = .scaleAspectFit
        element.frame = frame
        return element
    }
    
    private func fetchData() {
        episodNetworkManager.fetchEpisode { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.episods = episodes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

extension HomeViewController {
    private func setupConstraints() {
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            nameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchBar.topAnchor.constraint(equalTo: nameImage.bottomAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            filterButton.heightAnchor.constraint(equalToConstant: 56),
            filterButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = DescriptionViewController()
        
        episodNetworkManager.fetchCharacter(url: episods[indexPath.row].character) { [weak self] result in
            switch result {
            case .success(let character):
                self?.episodNetworkManager.fetchImage(url: character.image) { result in
                    switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            destVC.characterArray = character.getArray()
                            self?.navigationController?.pushViewController(destVC, animated: true)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }

                
            case .failure(let error):
                print("Error fetching data")
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell

      

        let model = episods[indexPath.row]
        cell.configure(with: model)

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space = sectionInsert.left * CGFloat(1)
        let availableWidth = view.frame.width - space
        let widthPerItem = availableWidth / CGFloat(1)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
