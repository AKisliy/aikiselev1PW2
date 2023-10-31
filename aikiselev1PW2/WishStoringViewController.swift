//
//  WishStrongViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.10.2023.
//

import UIKit

final class WishStoringViewController: UIViewController{
    enum Constants{
        static let tableCornerRadius: CGFloat = 15
        static let tableOffset: CGFloat = 10
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable(){
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else {return cell}
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
    
    
}
