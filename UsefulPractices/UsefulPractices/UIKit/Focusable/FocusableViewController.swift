//
//  FocusableViewController.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 17.06.2026.
//

import UIKit
import SwiftUI

// Examples for iPad
// po UIFocusDebugger.checkFocusability(for:)
// po UIFocusDebugger.checkFocusGroupTree(for:)

final class FocusableViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // All cells are focusable
        self.collectionView.allowsFocus = true
        self.collectionView.selectionFollowsFocus = true
        self.collectionView.register(
            FocusableCell.self,
            forCellWithReuseIdentifier: FocusableCell.cellId
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item % 2 == 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FocusableCell.cellId, for: indexPath)
        return cell
    }
}

final class FocusableCell: UICollectionViewCell {
    static var cellId = "FocusableCell"
    
    // MARK: Properties
    let fakeImageView = UIView()
    let badgeView = UIView()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        // Background View
        fakeImageView.backgroundColor = .lightGray
        fakeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fakeImageView)
        NSLayoutConstraint.activate([
            fakeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fakeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fakeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fakeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // BadgeView
        badgeView.backgroundColor = .systemRed
        badgeView.layer.cornerRadius = 20
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(badgeView)
        NSLayoutConstraint.activate([
            badgeView.centerXAnchor.constraint(equalTo: contentView.trailingAnchor),
            badgeView.centerYAnchor.constraint(equalTo: contentView.topAnchor),
            badgeView.widthAnchor.constraint(equalToConstant: 40),
            badgeView.heightAnchor.constraint(equalTo: badgeView.widthAnchor, multiplier: 1)
        ])
        
        // Focus Effect
        let focusEffect = UIFocusHaloEffect(
            roundedRect: self.bounds,
            cornerRadius: 12,
            curve: .circular
        )
        // Added focus effect below badge
        focusEffect.containerView = contentView
        focusEffect.referenceView = fakeImageView
        self.focusEffect = focusEffect
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // Parent get focus changes of child too
        if context.nextFocusedItem === self {
            
        } else if context.previouslyFocusedItem === self {
            
        }
    }
}

// MARK: Wrapper
struct FocusableViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100)
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 24
        layout.sectionInset = .zero
        return FocusableViewController(collectionViewLayout: layout)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

// MARK: Preview
#Preview {
    FocusableViewControllerWrapper()
        .ignoresSafeArea()
}
