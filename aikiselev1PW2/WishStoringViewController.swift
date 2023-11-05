//
//  WishStrongViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.10.2023.
//

import UIKit

final class WishStoringViewController: UIViewController{
    private enum Constants{
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 10
        static let numberOfSections: Int = 2
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable(){
        view.addSubview(table)
        table.backgroundColor = .systemPink
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    func newWishAdded(wish: String) {
        wishArray.append(wish)
        table.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
                as? AddWishCell{
                addNewCell.addWish = newWishAdded
                return addNewCell
            }
        default:
            let wish = wishArray[indexPath.row]
            if let wishCell = table.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as? WrittenWishCell{
                wishCell.configure(with: wish)
                return wishCell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return wishArray.count
        }
    }
}
