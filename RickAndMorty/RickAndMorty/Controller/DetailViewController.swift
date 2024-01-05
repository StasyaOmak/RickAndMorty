//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 04/01/2024.
//

import UIKit

class DetailViewController: UIViewController {
    var detailModel: DetailModel!
    
    private lazy var myTableView: UITableView = {
        let element = UITableView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var imageContainerView: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var photoImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleToFill
        element.layer.cornerRadius = 74
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cameraButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "camera"), for: .normal)
        element.tintColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.text = ""
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 32)
        element.textColor = UIColor(red: 0.03, green: 0.12, blue: 0.2, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var infoLabel: UILabel = {
        let element = UILabel()
        element.text = "Information"
        element.font = .systemFont(ofSize: 20)
        element.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupActions()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let buttonItem = UIBarButtonItem(image: UIImage(named: "logo_black"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = buttonItem
        
        let logoImage = UIImage(named: "logo_black")
            let logoBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
            logoBarButtonItem.tintColor = .black
            navigationItem.rightBarButtonItem = logoBarButtonItem

            let backButton = UIBarButtonItem()
            backButton.title = "GO BACK"
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupActions() {
        cameraButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
    }

    @objc private func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(myTableView)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellOne")
        view.addSubview(mainStackView)
        
        imageContainerView.addSubview(photoImageView)
        imageContainerView.addSubview(cameraButton)
        
        mainStackView.addArrangedSubview(imageContainerView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(infoLabel)
        
        photoImageView.image = detailModel.image
        nameLabel.text = detailModel.name
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailModel.characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellOne")
        
        let model = detailModel.characterArray[indexPath.row]
  
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subTitle
        cell.selectionStyle = .none
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)

        return cell
    }
}

extension DetailViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            photoImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            photoImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -10),
            photoImageView.heightAnchor.constraint(equalToConstant: 148),
            photoImageView.widthAnchor.constraint(equalToConstant: 148),
            
            cameraButton.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            cameraButton.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            
            myTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            myTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            myTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
