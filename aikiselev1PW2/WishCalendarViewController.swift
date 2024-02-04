//
//  WishCalendarViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.01.2024.
//

import UIKit

class WishCalendarViewController: UIViewController{
    
    enum Constants{
        static let contentInset: UIEdgeInsets = .zero
        
        static let collectionTop: CGFloat = 15
        
        static let cellHeight: CGFloat = 100
        
        static let numberOfRows : Int = 10
    }
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        configureCollection()
    }
    
    private func configureCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            layout.invalidateLayout()
        }
        // Temporary
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else{
            return cell
        }
        
        wishEventCell.configure(
            with: WishEventModel(
                title: "Title",
                description: "Description" ,
                startDate: "Start date",
                endDate: "End date")
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10 , height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
