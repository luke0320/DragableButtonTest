//
//  ViewController.swift
//  ButtonLayout
//
//  Created by Luke Lee on 2021/9/7.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - constants
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let minimumInteritemSpacing: CGFloat = 10
    
    private let minimumLineSpacing: CGFloat = 10
    
    private let numberOfColumnInOnePage = 2
    
    private let numberOfRowInOnePage = 3
    
    private let dragNDropTypeId = "dragNDropId"
    
    //MARK: - ui
    private var collectionView: UICollectionView!
    
    //MARK: - data
    private var myButtons = [
        MyButton(title: "One", colorHex: 0x483C32, action: .openWebPage(url: URL(string: "https://www.google.com")!)),
        MyButton(title: "Two", colorHex: 0x635345, action: .openPlainPage),
        MyButton(title: "Three", colorHex: 0x7E6958, action: .openPlainPage),
        MyButton(title: "Four", colorHex: 0x98806B, action: .openPlainPage),
        MyButton(title: "Five", colorHex: 0xAB9786, action: .openPlainPage),
        MyButton(title: "Six", colorHex: 0xBEAEA1, action: .openPlainPage)
    ]
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Root"
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    //MARK: - ui configuration
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.backgroundColor = .clear
        collectionView.dragInteractionEnabled = true
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

}

//MARK: - UICollectionView Delegate Methods
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let button = myButtons[indexPath.row]
        var vc: UIViewController
        switch button.action {
        case .openWebPage(let url):
            vc = MyWebPage(url: url)
        case .openPlainPage:
            vc = UIViewController()
            vc.view.backgroundColor = UIColor(hex: button.colorHex)
        }
        vc.title = button.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionView DataSource Methods
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.cellId, for: indexPath) as! ButtonCell
        let button = myButtons[indexPath.row]
        cell.titleLabel.text = button.title
        cell.backgroundColor = UIColor(hex: button.colorHex)
        return cell
    }
}

//MARK: - UICollectionView DelegateFlowLayout Methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpacing = minimumInteritemSpacing * CGFloat(numberOfColumnInOnePage - 1)
        let verticalSpacing = minimumLineSpacing * CGFloat(numberOfRowInOnePage - 1)
        
        return CGSize(
            width: (collectionView.frame.width - sectionInsets.left - sectionInsets.right - horizontalSpacing) / CGFloat(numberOfColumnInOnePage),
            height: (collectionView.frame.height - sectionInsets.top - sectionInsets.bottom - verticalSpacing) / CGFloat(numberOfRowInOnePage)
        )
    }
}

//MARK: - UICollectionView Drag Delegate Methods
extension ViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let button = myButtons[indexPath.row]
        let itemProvider = NSItemProvider(
            item: button.title.data(using: .utf8) as NSData?,
            typeIdentifier: dragNDropTypeId
        )
        
        return [UIDragItem(itemProvider: itemProvider)]
    }
}

//MARK: - UICollectionView Drop Delegate Methods
extension ViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        guard
            coordinator.session.hasItemsConforming(toTypeIdentifiers: [dragNDropTypeId]),
            coordinator.proposal.operation == .move,
            let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath,
            let destinationIndexPath = coordinator.destinationIndexPath
        else {
            return
        }
        
        collectionView.performBatchUpdates {
            let button = self.myButtons.remove(at: sourceIndexPath.row)
            self.myButtons.insert(button, at: destinationIndexPath.row)
            collectionView.deleteItems(at: [sourceIndexPath])
            collectionView.insertItems(at: [destinationIndexPath])
        } completion: { _ in }

        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
}
