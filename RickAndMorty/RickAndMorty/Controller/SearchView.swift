//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import UIKit

class SearchView: UIView {
  var container: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 8.0
    view.layer.borderWidth = 1.0
    view.tintColor = .gray
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var searchIcon: UIImageView = {
    let img = UIImage(systemName: "magnifyingglass")
    let view = UIImageView(image: img)
      view.tintColor = .gray
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  var input: UITextField = {
    let view = UITextField()
    view.placeholder = "Name or episode (ex.S01E01)..."
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false

    setupSubviews()
    setupConstraints()
  }

  private func setupSubviews() {
    searchIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    container.addSubview(searchIcon)
    container.addSubview(input)
    addSubview(container)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: topAnchor),
      container.leadingAnchor.constraint(equalTo: leadingAnchor),
      container.trailingAnchor.constraint(equalTo: trailingAnchor),
      container.bottomAnchor.constraint(equalTo: bottomAnchor),

      searchIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.0),
      searchIcon.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0),
      searchIcon.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.0),

      input.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8.0),
      input.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.0),
      input.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.0),
      input.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.0)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

