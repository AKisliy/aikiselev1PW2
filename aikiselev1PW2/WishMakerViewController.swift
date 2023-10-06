//
//  ViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 24.09.2023.
//

import UIKit

class WishMakerViewController: UIViewController {
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        
        static let titleFont: Double = 32
        static let titleLeading: CGFloat = 30
        static let titleTop: CGFloat = 30
        static let titleText: String = "WishMaker"
        
        static let descriptionFont: Double = 20
        static let descriptionLeading: CGFloat = 30
        static let descriptionTop: CGFloat = 20
        static let descriptionText: String = "This app can change the colour of your screen."
        
        static let stackRadius: CGFloat = 20
        static let stackLeading: CGFloat = 20
        static let stackBottom: CGFloat = 50
        
        static let buttonText: String = "Hide"
        static let buttonBottom: CGFloat = 20
        
    }
    
    private let sliderStack: UIStackView = UIStackView()
    private let button: UIButton = UIButton()
    private let titleView = UILabel()
    private let desciprionView = UILabel()
    private var currentRed:CGFloat = 0
    private var currentGreen:CGFloat = 0
    private var currentBlue:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func hideSlider(){
        sliderStack.isHidden = !sliderStack.isHidden
    }
    
    private func configureUI(){
        view.backgroundColor = .systemPink
        let coreColor = view.backgroundColor?.coreImageColor
        currentRed = coreColor!.red
        currentBlue = coreColor!.blue
        currentGreen = coreColor!.green
        configureTitle()
        configureDescription()
        configureSliders()
        configureButton()
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
        desciprionView.translatesAutoresizingMaskIntoConstraints = false
        desciprionView.text = Constants.descriptionText
        desciprionView.adjustsFontSizeToFitWidth = true
        desciprionView.font = UIFont.systemFont(ofSize: Constants.descriptionFont)
        
        view.addSubview(desciprionView)
        desciprionView.pinXCenter(to: view)
        desciprionView.pinLeft(to: view, Constants.descriptionLeading)
        desciprionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTop)
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
        sliderStack.pinBottom(to: view, Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: CGFloat(sliderRed.slider.value), green: self!.currentGreen, blue: self!.currentBlue, alpha: 1.0)
            self?.currentRed = CGFloat(sliderRed.slider.value)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: self!.currentRed, green: self!.currentGreen, blue: CGFloat(sliderBlue.slider.value), alpha: 1.0)
            self?.currentBlue = CGFloat(sliderBlue.slider.value)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(red: self!.currentRed, green: CGFloat(sliderGreen.slider.value), blue: self!.currentBlue, alpha: 1.0)
            self?.currentGreen = CGFloat(sliderGreen.slider.value)
        }
    }
    
    private func configureButton(){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonText, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(hideSlider), for: .touchDown)
        button.layer.cornerRadius = Constants.stackRadius

        view.addSubview(button)
        
        button.pinBottom(to: sliderStack.topAnchor, Constants.buttonBottom)
        button.pinLeft(to: view.leadingAnchor, Constants.stackLeading)
        button.pinRight(to: view.centerXAnchor)
    }
}

