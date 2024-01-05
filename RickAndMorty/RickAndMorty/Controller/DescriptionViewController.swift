//
//  DescriptionViewController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 04/01/2024.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var characterArray: [Descr] = []
    
    private lazy var myTableView: UITableView = {
        let element = UITableView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(myTableView)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellOne")
        
    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(characterArray.count)
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellOne")
        
        let model = characterArray[indexPath.row]
  
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.subTitle
        cell.selectionStyle = .none
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)

        return cell
    }
    
    
    
}

extension DescriptionViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
