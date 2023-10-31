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
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
