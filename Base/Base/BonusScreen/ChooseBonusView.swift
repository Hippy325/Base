//
//  ChooseBonusView.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import UIKit

final class ChooseBonusView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label =  UILabel()
        label.text = "Choose your bonus"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var oneImage = ChooseImageView(index: 0, isActive: true, closure: selectNewImage)
    lazy var twoImage = ChooseImageView(index: 1, isActive: false, closure: selectNewImage)
    lazy var threeImage = ChooseImageView(index: 2, isActive: false, closure: selectNewImage)
    lazy var fourImage = ChooseImageView(index: 3, isActive: false, closure: selectNewImage)
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 41
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(oneImage)
        stackView.addArrangedSubview(twoImage)
        return stackView
    }()
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 41
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(threeImage)
        stackView.addArrangedSubview(fourImage)
        return stackView
    }()
    private lazy var daysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var grabButton: UIButton = {
        let button = UIButton()
        button.setTitle("GRAB", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.backgroundColor = .bgGreen
        button.addTarget(self, action: #selector(tapOnGrab), for: .touchUpInside)
        return button
    }()
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.addTarget(self, action: #selector(tapOnOK), for: .touchUpInside)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(grabButton)
        stackView.addArrangedSubview(okButton)
        return stackView
    }()
    private var selectedIndex = 0
    var closure: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(textLabel)
        addSubview(daysStackView)
        addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            daysStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            daysStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            daysStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            daysStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            daysStackView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabButton.heightAnchor.constraint(equalToConstant: 35),
            grabButton.widthAnchor.constraint(equalToConstant: 172),
            okButton.heightAnchor.constraint(equalToConstant: 35),
            okButton.widthAnchor.constraint(equalToConstant: 172),
        ])
    }
    
    private func selectNewImage(_ index: Int) {
        selectedIndex = index
        switch index {
        case 0:
            oneImage.configure(isActive: true)
            twoImage.configure(isActive: false)
            threeImage.configure(isActive: false)
            fourImage.configure(isActive: false)
        case 1:
            oneImage.configure(isActive: false)
            twoImage.configure(isActive: true)
            threeImage.configure(isActive: false)
            fourImage.configure(isActive: false)
        case 2:
            oneImage.configure(isActive: false)
            twoImage.configure(isActive: false)
            threeImage.configure(isActive: true)
            fourImage.configure(isActive: false)
        case 3:
            oneImage.configure(isActive: false)
            twoImage.configure(isActive: false)
            threeImage.configure(isActive: false)
            fourImage.configure(isActive: true)
        default: return
        }
    }
    
    @objc private func tapOnGrab() {
        UserDefaults.standard.setValue(selectedIndex, forKey: "indexForImage")
        let selectedImageName = BonusModel.getImagesName(index: selectedIndex)
        if let image = UIImage(named: selectedImageName) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        BonusModel.newWeak()
        closure?()
    }
    
    @objc private func tapOnOK() {
        closure?()
    }
}
