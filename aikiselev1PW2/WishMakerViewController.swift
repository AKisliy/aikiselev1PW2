//
//  ViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 24.09.2023.
//

import UIKit

class WishMakerViewController: UIViewController {
    
    enum Constants {
        static let spacing: CGFloat = 10
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        
        static let titleFont: Double = 32
        static let titleLeading: CGFloat = 30
        static let titleTop: CGFloat = 30
        static let titleText: String = "WishMaker"
        
        static let colorAlpha: Double = 1.0
        
        static let descriptionFont: Double = 20
        static let descriptionLeading: CGFloat = 30
        static let descriptionTop: CGFloat = 20
        static let descriptionText: String = "This app can change the colour of your screen."
        
        static let stackRadius: CGFloat = 20
        static let stackLeading: CGFloat = 20
        static let stackBottom: CGFloat = 30
        
        static let hideButtonText: String = "Hide"
        static let hideButtonBottom: CGFloat = 20
        static let hideButtonHeight: CGFloat = 30
        
        static let addWishButtonText: String = "My wishes"
        static let addWishButtonHeight: CGFloat = 50
        static let addWishButtonRaduius: CGFloat = 15
        
        static let scheduleWishesButtonText: String = "Schedule wishes"
        static let scheduleWishesButtonRadius: CGFloat = 15
        static let scheduleWishedButtonHeight: CGFloat = 50
        
    }
    
    private let sliderStack: UIStackView = UIStackView()
    private let hideButton: UIButton = UIButton()
    private let titleView = UILabel()
    private let descriptionView = UILabel()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    private let actionStack: UIStackView = UIStackView()
    private var currentRed:CGFloat = 0
    private var currentGreen:CGFloat = 0
    private var currentBlue:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func hideSlider(){
        sliderStack.isHidden.toggle()
    }
    
    private func configureUI(){
        view.backgroundColor = .systemPink
        let coreColor = view.backgroundColor?.coreImageColor
        currentRed = coreColor!.red
        currentBlue = coreColor!.blue
        currentGreen = coreColor!.green
        configureTitle()
        configureDescription()
        configureAddWishButton()
        configureScheduleWishesButton()
        configureActionStack()
        configureSliders()
        configureHideButton()
    }
    
    private func configureTitle(){
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        titleView.font = UIFont.systemFont(ofSize: Constants.titleFont, weight: .bold)
        
        view.addSubview(titleView)
        titleView.pinXCenter(to: view)
        titleView.pinLeft(to: view, Constants.titleLeading)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    private func configureDescription(){
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.descriptionText
        descriptionView.adjustsFontSizeToFitWidth = true
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFont)
        
        view.addSubview(descriptionView)
        descriptionView.pinXCenter(to: view)
        descriptionView.pinLeft(to: view, Constants.descriptionLeading)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTop)
    }
    
    private func configureSliders(){
        sliderStack.translatesAutoresizingMaskIntoConstraints = false
        sliderStack.axis = .vertical
        view.addSubview(sliderStack)
        sliderStack.layer.cornerRadius = Constants.stackRadius
        sliderStack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderRed.slider.value = Float(currentRed)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderBlue.slider.value = Float(currentBlue)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderGreen.slider.value = Float(currentGreen)
        for slider in [sliderRed, sliderBlue, sliderGreen]{
            sliderStack.addArrangedSubview(slider)
        }
        
        sliderStack.pinXCenter(to: view)
        sliderStack.pinLeft(to: view, Constants.stackLeading)
        sliderStack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: self!.currentGreen, blue: self!.currentBlue, alpha: Constants.colorAlpha)
            self?.currentRed = CGFloat(sliderRed.slider.value)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: self!.currentRed, green: self!.currentGreen, blue: CGFloat(sliderBlue.slider.value), alpha: Constants.colorAlpha)
            self?.currentBlue = CGFloat(sliderBlue.slider.value)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: self!.currentRed, green: CGFloat(sliderGreen.slider.value), blue: self!.currentBlue, alpha: Constants.colorAlpha)
            self?.currentGreen = CGFloat(sliderGreen.slider.value)
        }
    }
    
    private func configureHideButton(){
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(Constants.hideButtonText, for: .normal)
        hideButton.backgroundColor = .blue
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.addTarget(self, action: #selector(hideSlider), for: .touchDown)
        hideButton.layer.cornerRadius = Constants.stackRadius

        view.addSubview(hideButton)
        
        hideButton.pinBottom(to: sliderStack.topAnchor, Constants.hideButtonBottom)
        hideButton.pinLeft(to: view.leadingAnchor, Constants.stackLeading)
        hideButton.pinRight(to: view.centerXAnchor)
        hideButton.setHeight(value: Constants.hideButtonHeight)
    }
    
    private func configureAddWishButton(){
        view.addSubview(addWishButton)
        addWishButton.setHeight(value: Constants.addWishButtonHeight)

        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.addWishButtonRaduius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureScheduleWishesButton(){
        view.addSubview(scheduleWishesButton)
        scheduleWishesButton.setHeight(value: Constants.scheduleWishedButtonHeight)
        
        scheduleWishesButton.backgroundColor = .white
        scheduleWishesButton.setTitleColor(.systemPink, for: .normal)
        scheduleWishesButton.setTitle(Constants.scheduleWishesButtonText, for: .normal)
        
        scheduleWishesButton.layer.cornerRadius = Constants.scheduleWishesButtonRadius
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonPressed), for: .touchUpInside)
    }
    
    private func configureActionStack(){
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        
        for button in [addWishButton, scheduleWishesButton]{
            actionStack.addArrangedSubview(button)
        }
    
        
        actionStack.pinBottom(to: view, Constants.stackBottom)
        actionStack.pinHorizontal(to: view, Constants.stackLeading)
    }
    
    @objc
    private func addWishButtonPressed(){
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func scheduleWishesButtonPressed(){
        
    }
}

