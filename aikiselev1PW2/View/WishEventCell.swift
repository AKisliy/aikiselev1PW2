//
//  WishEventCell.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.01.2024.
//

import UIKit

class WishEventCell: UICollectionViewCell{
    
    enum Constants{
        static let cornerRadius: CGFloat = 15
        static let offset: CGFloat = 7
        static let backgroundColor: UIColor = .white
        
        static let textColor: UIColor = .black
        
        static let titleTop: CGFloat = 5
        static let titleFont: UIFont = .italicSystemFont(ofSize: 20)
        static let titleLeading: CGFloat = 5
        
        static let descriptionTop: CGFloat = 5
        static let descriptionLeading: CGFloat = 5
        static let descriptionFont: UIFont = .systemFont(ofSize: 10)
        
        static let startLabelBottom: CGFloat = 15
        static let startLabelTrailing: CGFloat = 5
        static let startLabelFont: UIFont = .systemFont(ofSize: 8)
        
        static let endLabelBottom: CGFloat = 5
        static let endLabelTrailing: CGFloat = 5
        static let endLabelFont: UIFont = .systemFont(ofSize: 8)
    }
    
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell configuration
    func configure(with event: WishEventModel){
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YYYY"

        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start: \(df.string(from: event.startDate))"
        endDateLabel.text = "End: \(df.string(from: event.endDate))"
    }
    
    // MARK: - Configure UI
    private func configureWrap(){
        addSubview(wrapView)
        
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel(){
        addSubview(titleLabel)
        
        titleLabel.textColor = Constants.textColor
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel(){
        addSubview(descriptionLabel)
        
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
        descriptionLabel.pinLeft(to: wrapView, Constants.descriptionLeading)
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = Constants.textColor
    }
    
    private func configureStartDateLabel(){
        addSubview(startDateLabel)
        
        startDateLabel.pinBottom(to: wrapView, Constants.startLabelBottom)
        startDateLabel.pinRight(to: wrapView, Constants.startLabelTrailing)
        startDateLabel.font = Constants.startLabelFont
        startDateLabel.textColor = Constants.textColor
    }
    
    private func configureEndDateLabel(){
        addSubview(endDateLabel)
        
        endDateLabel.pinBottom(to: wrapView, Constants.endLabelBottom)
        endDateLabel.pinRight(to: wrapView, Constants.endLabelTrailing)
        endDateLabel.font = Constants.endLabelFont
        endDateLabel.textColor = Constants.textColor
    }
}
