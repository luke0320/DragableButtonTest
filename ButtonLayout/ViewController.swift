//
//  ViewController.swift
//  ButtonLayout
//
//  Created by Luke Lee on 2021/9/7.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    
    private let myButtons = [
        MyButton(title: "One", color: .red, action: .openWebPage(url: URL(string: "https://www.google.com")!)),
        MyButton(title: "Two", color: .orange, action: .openPlainPage),
        MyButton(title: "Three", color: .yellow, action: .openPlainPage),
        MyButton(title: "Four", color: .green, action: .openPlainPage),
        MyButton(title: "Five", color: .blue, action: .openPlainPage),
        MyButton(title: "Six", color: .purple, action: .openPlainPage)
    ]
    
    private let cellId = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Root"
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.frame = CGRect(origin: .zero, size: size)
    }
    
    private func setupCollectionView() {
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = insets
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(
            width: (view.frame.width - insets.left - insets.right - 10)/2,
            height: (view.frame.height - insets.top - insets.bottom - 10 * 2)/3
        )
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let button = myButtons[indexPath.row]
        var vc: UIViewController
        switch button.action {
        case .openWebPage(let url):
            vc = MyWebPage(url: url)
        case .openPlainPage:
            vc = UIViewController()
        }
        vc.title = button.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ButtonCell
        
        return cell
    }
}

class ButtonCell: UICollectionViewCell {

    static let cellId = "ButtonCell"
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lbl.layer.cornerRadius = 5
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCell() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
