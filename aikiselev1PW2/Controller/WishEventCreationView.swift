//
//  WishEventCreationView.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 04.02.2024.
//

import UIKit

class WishEventCreationView: UIViewController{
    private enum Constants{
        static let labelFont: UIFont = .boldSystemFont(ofSize: 25)
        static let textViewFont: UIFont = .systemFont(ofSize: 15)
        static let textViewCornerRadius: CGFloat = 12
        static let textViewWidthDelta: CGFloat = 30
        
        static let nameTextViewHeight: CGFloat = 40
        
        static let descriptionTextViewHeight: CGFloat = 60
        
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        static let buttonTextColor: UIColor = .green
        static let buttonFontSize: CGFloat = 12
        static let buttonConerRadius: CGFloat = 25
        static let buttonHeight: CGFloat = 70
        static let buttonWidth: CGFloat = 150
        
        static let stackSpacing: CGFloat = 8
        static let stackPin: CGFloat = 15
        
        static let errorLabelFont: UIFont = .systemFont(ofSize: 10)
    }
    
    private var nameLabel: UILabel = UILabel()
    private var nameTextView = UITextView()
    private var descriptionLabel: UILabel = UILabel()
    private  var descriptionTextView = UITextView()
    private var startDateLabel = UILabel()
    private var startDateTextView = UITextView()
    private var endDateLabel = UILabel()
    private var endDateTextView = UITextView()
    private var addEventButton = UIButton()
    private var errorDateLabel: UILabel = UILabel()
    private var emptyFieldsLabel: UILabel = UILabel()
    
    var addEvent: ((WishEventModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .systemTeal
        configureLabels()
        configureTextViews()
        configureButton()
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel, nameTextView,
            descriptionLabel, descriptionTextView,
            startDateLabel, startDateTextView,
            endDateLabel, endDateTextView,
            addEventButton,
            errorDateLabel, emptyFieldsLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.pinTop(to: view, Constants.stackPin)
        stackView.pinXCenter(to: view)
    }
    
    private func configureLabels(){
        nameLabel.text = "Event name"
        nameLabel.font = Constants.labelFont
        
        descriptionLabel.text = "Describe event"
        descriptionLabel.font = Constants.labelFont
        
        startDateLabel.text = "Set start date"
        startDateLabel.font = Constants.labelFont
        
        endDateLabel.text = "Set end date"
        endDateLabel.font = Constants.labelFont
        
        errorDateLabel.text = "Date should look like: DD.MM.YYYY"
        errorDateLabel.font = Constants.errorLabelFont
        errorDateLabel.isHidden = true
        errorDateLabel.textColor = .red
        
        emptyFieldsLabel.text = "All fields are required!"
        emptyFieldsLabel.font = Constants.errorLabelFont
        emptyFieldsLabel.isHidden = true
        emptyFieldsLabel.textColor = .red
    }
    
    private func configureTextViews(){
        nameTextView.font = Constants.textViewFont
        nameTextView.backgroundColor = .white
        nameTextView.setHeight(value: Constants.nameTextViewHeight)
        nameTextView.layer.cornerRadius = Constants.textViewCornerRadius
        nameTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        descriptionTextView.font = Constants.textViewFont
        descriptionTextView.backgroundColor = .white
        descriptionTextView.setHeight(value: Constants.descriptionTextViewHeight)
        descriptionTextView.layer.cornerRadius = Constants.textViewCornerRadius
        descriptionTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        startDateTextView.font = Constants.textViewFont
        startDateTextView.backgroundColor = .white
        startDateTextView.setHeight(value: Constants.nameTextViewHeight)
        startDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        startDateTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
        
        endDateTextView.font = Constants.textViewFont
        endDateTextView.backgroundColor = .white
        endDateTextView.setHeight(value: Constants.nameTextViewHeight)
        endDateTextView.layer.cornerRadius = Constants.textViewCornerRadius
        endDateTextView.setWidth(value: view.frame.width - Constants.textViewWidthDelta)
    }
    
    private func configureButton(){
        addEventButton.setTitle("Add new event", for: .normal)
        addEventButton.titleLabel?.font = Constants.buttonFont
        addEventButton.setTitleColor(Constants.buttonTextColor, for: .normal)
        addEventButton.backgroundColor = .white
        addEventButton.layer.cornerRadius = Constants.buttonConerRadius
        addEventButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addEventButton.isEnabled = true
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setHeight(value: Constants.buttonHeight)
        addEventButton.setWidth(value: Constants.buttonWidth)
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let name = nameTextView.text!
        let description = descriptionTextView.text!
        let startDate = startDateTextView.text!
        let endDate = endDateTextView.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if(name.isEmpty || description.isEmpty || startDate.isEmpty || endDate.isEmpty){
            showEmptyFieldsError()
            return
        }
        emptyFieldsLabel.isHidden = true
        if let startDate = dateFormatter.date(from: startDate), let endDate = dateFormatter.date(from: endDate){
            addEvent!(WishEventModel(title: name, description: description, startDate: startDate, endDate: endDate))
        }
        else{
            showErrorDate()
            return
        }
        nameTextView.text = ""
        descriptionTextView.text = ""
        startDateTextView.text = ""
        endDateTextView.text = ""
        errorDateLabel.isHidden = true
        emptyFieldsLabel.isHidden = true
    }
    
    private func showErrorDate(){
        errorDateLabel.isHidden = false
    }
    
    private func showEmptyFieldsError(){
        emptyFieldsLabel.isHidden = false
    }
}




