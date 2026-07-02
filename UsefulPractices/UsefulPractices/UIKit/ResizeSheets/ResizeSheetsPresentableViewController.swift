//
//  ResizeSheetsPresentableViewController.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 19.06.2026.
//

import UIKit
import SwiftUI

final class ResizeSheetsPresentableViewController: UICollectionViewController {
    // MARK: Callbacks
    var didSelectColor: ((UIColor) -> Void)?
    
    // MARK: Constants
    private let basicCellIdentifier = "BasicCell"
    private let colors: [UIColor] = [
        .systemRed, .systemOrange, .systemGreen, .systemBlue, .systemPink, .systemCyan
    ]
    
    // MARK: Initializers
    init() {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(
            group: group
        )
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: basicCellIdentifier, for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.item]
        didSelectColor?(color)
    }
}

private extension ResizeSheetsPresentableViewController {
    func setup() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: basicCellIdentifier)
    }
}

#Preview {
    ResizeSheetsPresentableViewController()
}
