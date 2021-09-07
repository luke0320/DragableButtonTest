//
//  ButtonCell.swift
//  ButtonLayout
//
//  Created by Luke on 2021/9/7.
//

import UIKit

class ButtonCell: UICollectionViewCell {

    //MARK: - constants
    static let cellId = "ButtonCell"
    
    //MARK: - ui
    let titleLabel = UILabel()
    
    private let labelContainer = UIView()
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelContainer()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - ui configuration
    private func setupLabelContainer() {
        labelContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        labelContainer.layer.cornerRadius = 5
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelContainer)
        NSLayoutConstraint.activate([
            labelContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelContainer.heightAnchor.constraint(equalToConstant: 50),
            labelContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupLabel() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor)
        ])
    }
}

