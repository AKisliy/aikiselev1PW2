//
//  AddWishCell.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 05.11.2023.
//

import UIKit

final class AddWishCell:UITableViewCell{
    private enum Constants{
        static let textFontSize: CGFloat = 12
        static let textViewHeight: CGFloat = 30
        static let textViewCornerRadius: CGFloat = 12
        
        static let buttonFontSize: CGFloat = 12
        static let buttonConerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 30
        
        static let stackSpacing: CGFloat = 8
        static let stackPin: CGFloat = 15
    }
    static let reuseId: String = "AddWishCell"
    private var textView = UITextView()
    private var addWishButton = UIButton()
    
    var addWish: ((String) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        textView.font = .systemFont(ofSize: Constants.textFontSize)
        textView.backgroundColor = .white
        textView.setHeight(value: Constants.textViewHeight)
        textView.layer.cornerRadius = Constants.textViewCornerRadius
        
        addWishButton.setTitle("Add new wish", for: .normal)
        addWishButton.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        addWishButton.setTitleColor(.systemIndigo, for: .normal)
        addWishButton.backgroundColor = .white
        addWishButton.layer.cornerRadius = Constants.buttonConerRadius
        addWishButton.setHeight(value: Constants.buttonHeight)
        addWishButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addWishButton.isEnabled = true
        
        let stackView = UIStackView(arrangedSubviews: [textView, addWishButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, Constants.stackPin)
        contentView.backgroundColor = .cyan
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let wish = self.textView.text!
        if(!wish.isEmpty){
            addWish!(wish)
        }
        textView.text = ""
    }
}
