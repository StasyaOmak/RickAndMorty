//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 03/01/2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let episodNetworkManager = EpisodNetworkManager()
    private var isFavorite = false
    
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .fill
        element.spacing = 10
        element.clipsToBounds = true
        element.layer.cornerRadius = 5
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var pictureStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var episodStackView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var hurtIconImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "heart")
        element.tintColor = UIColor(red: 0.07, green: 0.69, blue: 0.78, alpha: 1)
        element.contentMode = .scaleToFill
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHeart))
        element.isUserInteractionEnabled = true
        element.addGestureRecognizer(tapGesture)

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let playIconImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "play.tv")
        element.tintColor = UIColor.systemGray
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let slashLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.text = "|"
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let stateLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let episodeNameLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.textAlignment = .left
        element.textColor = UIColor(red: 0.192, green: 0.196, blue: 0.204, alpha: 1)
        element.font = .systemFont(ofSize: 16)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let episodeNumberLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let episodeImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 5
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOpacity = 0.5
        element.layer.shadowOffset = CGSize(width: 0, height: 2)
        element.layer.shadowRadius = 7
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with episode: EpisodModel) {
        episodeNameLabel.text = "\(episode.name) | \(episode.episode)"
        episodNetworkManager.fetchCharacter(url: episode.character) { [weak self] result in
            switch result {
            case .success(let character):
                self?.episodNetworkManager.fetchImage(url: character.image) { result in
                    switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            self?.episodeImageView.image = success
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }

                DispatchQueue.main.async {
                    self?.nameLabel.text = character.name
                    self?.stateLabel.text = character.species
                }
            case .failure(let error):
                print("Error fetching data")
            }
        }
    }
    
    @objc private func tapHeart() {
        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        let color = !isFavorite ? UIColor(red: 0.07, green: 0.69, blue: 0.78, alpha: 1) : .red
        hurtIconImageView.tintColor = color
        hurtIconImageView.image = UIImage(systemName: imageName)
    }
    
    
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(pictureStackView)
        mainStackView.addArrangedSubview(episodStackView)
        
        pictureStackView.addArrangedSubview(episodeImageView)
        pictureStackView.addArrangedSubview(nameLabel)
        pictureStackView.addArrangedSubview(stateLabel)
        
        episodStackView.addSubview(playIconImageView)
        episodStackView.addSubview(episodeNameLabel)
        episodStackView.addSubview(hurtIconImageView)
    }
}

extension MainCollectionViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            playIconImageView.topAnchor.constraint(equalTo: episodStackView.topAnchor, constant: 22),
            playIconImageView.leadingAnchor.constraint(equalTo: episodStackView.leadingAnchor, constant: 22),
            playIconImageView.bottomAnchor.constraint(equalTo: episodStackView.bottomAnchor, constant: -14),
            playIconImageView.heightAnchor.constraint(equalToConstant: 34),
            playIconImageView.widthAnchor.constraint(equalToConstant: 34),
            
            episodeNameLabel.leadingAnchor.constraint(equalTo: playIconImageView.trailingAnchor, constant: 10),
            episodeNameLabel.centerYAnchor.constraint(equalTo: playIconImageView.centerYAnchor),
            
            hurtIconImageView.topAnchor.constraint(equalTo: episodStackView.topAnchor, constant: 17),
            hurtIconImageView.trailingAnchor.constraint(equalTo: episodStackView.trailingAnchor, constant: -18),
            hurtIconImageView.leadingAnchor.constraint(equalTo: episodeNameLabel.trailingAnchor, constant: 10),
            hurtIconImageView.bottomAnchor.constraint(equalTo: episodStackView.bottomAnchor, constant: -14),
            hurtIconImageView.widthAnchor.constraint(equalToConstant: 40),
            hurtIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
