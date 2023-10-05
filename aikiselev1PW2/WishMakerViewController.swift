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
        
    }
    
    private let titleView = UILabel()
    private let desciprionView = UILabel()
    private var currentRed:CGFloat = 0
    private var currentGreen:CGFloat = 0
    private var currentBlue:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        view.backgroundColor = .systemPink
        let coreColor = view.backgroundColor?.coreImageColor
        currentRed = coreColor!.red
        currentBlue = coreColor!.blue
        currentGreen = coreColor!.green
        configureTitle()
        configureDescriprion()
        configureSliders()
    }
    
    private func configureTitle(){
        // здесь мы говорим не использовать авто компоновку
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        titleView.font = UIFont.systemFont(ofSize: Constants.titleFont, weight: .bold)
        
        view.addSubview(titleView)
        titleView.pinXCenter(to: view)
        titleView.pinLeft(to: view, Constants.titleLeading)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
//        NSLayoutConstraint.activate([
//            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
//            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:Constants.titleTop)
//        ])
    }
    
    private func configureDescriprion(){
        desciprionView.translatesAutoresizingMaskIntoConstraints = false
        desciprionView.text = Constants.descriptionText
        desciprionView.adjustsFontSizeToFitWidth = true
        desciprionView.font = UIFont.systemFont(ofSize: Constants.descriptionFont)
        
        view.addSubview(desciprionView)
        desciprionView.pinXCenter(to: view)
        desciprionView.pinLeft(to: view, Constants.descriptionLeading)
        desciprionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTop)
//        NSLayoutConstraint.activate([
//            desciprionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            desciprionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLeading),
//            desciprionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.descriptionTop)
//        ])
    }
    
    private func configureSliders(){
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderRed.slider.value = Float(currentRed)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderBlue.slider.value = Float(currentBlue)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderGreen.slider.value = Float(currentGreen)
        for slider in [sliderRed, sliderBlue, sliderGreen]{
            stack.addArrangedSubview(slider)
        }
        
        stack.pinXCenter(to: view)
        stack.pinLeft(to: view, Constants.stackLeading)
        stack.pinBottom(to: view, Constants.stackBottom)
        
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
//        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
//            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
//        ])
    }
}

