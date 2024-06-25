//
//  DaysBonusView.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import UIKit

final class DaysBonusView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label =  UILabel()
        label.text = "Welcome! Log into the app 7 days in a row and get a bonus."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 17
        stackView.distribution = .fillEqually
        let activeDays = BonusModel.getDays()
        [1, 2, 3, 4].forEach({
            stackView.addArrangedSubview(DayView(day: $0, isActive: activeDays.contains($0)))
        })
        return stackView
    }()
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 17
        stackView.distribution = .fillEqually
        let activeDays = BonusModel.getDays()
        [5, 6, 7].forEach({
            stackView.addArrangedSubview(DayView(day: $0, isActive: activeDays.contains($0)))
        })
        return stackView
    }()
    private lazy var daysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 25
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var grabButton: UIButton = {
        let button = UIButton()
        button.setTitle("GRAB", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.backgroundColor = .bgGreen
        return button
    }()
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
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
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            daysStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 44),
            daysStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            daysStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabButton.widthAnchor.constraint(equalToConstant: 172),
            okButton.widthAnchor.constraint(equalToConstant: 172),
        ])
    }
}
