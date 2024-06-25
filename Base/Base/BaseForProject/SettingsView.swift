//
//  SettingsView.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class SettingsView: UIView {
    
    weak var navigationController: UINavigationController?
    var closure: (() -> Void)?
    private let isMain: Bool
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        button.setTitleColor(.bgGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(goOnMainViewController), for: .touchUpInside)
        return button
    }()
    private lazy var newEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Event", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnNewEventViewController), for: .touchUpInside)
        return button
    }()
    private lazy var newMatchButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Match", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnNewEventViewController), for: .touchUpInside)
        return button
    }()
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calendar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnCalendarViewController), for: .touchUpInside)
        return button
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnSettingsViewController), for: .touchUpInside)
        return button
    }()
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnProfileViewController), for: .touchUpInside)
        return button
    }()
    private lazy var bonusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bonus", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.bgGray, for: .normal)
        button.addTarget(self, action: #selector(goOnBonusViewController), for: .touchUpInside)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 26
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(newEventButton)
        stackView.addArrangedSubview(newMatchButton)
        stackView.addArrangedSubview(calendarButton)
        stackView.addArrangedSubview(settingsButton)
        stackView.addArrangedSubview(profileButton)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(bonusButton)
        return stackView
    }()
    private lazy var quitButton: UIButton = {
        let button = UIButton()
        button.setTitle("QUIT", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(quitAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var rightBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(_ isMain: Bool = false) {
        self.isMain = isMain
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(backgroundView)
        addSubview(rightBackgroundView)
        backgroundView.addSubview(stackView)
        backgroundView.addSubview(quitButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 280),
            rightBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            rightBackgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            rightBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightBackgroundView.leftAnchor.constraint(equalTo: backgroundView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 36),
            stackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20),
            quitButton.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20),
            quitButton.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -20),
            quitButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -28),
        ])
    }
    
    @objc private func quitAction() {
        exit(0)
    }
    
    @objc private func goOnMainViewController() {
        if isMain {
            closure?()
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func goOnNewEventViewController() {
        navigationController?.pushViewController(NewEventViewController(), animated: true)
    }
    
    @objc private func goOnCalendarViewController() {
        navigationController?.pushViewController(CalendarViewController(), animated: true)
    }
    
    @objc private func goOnSettingsViewController() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc private func goOnProfileViewController() {
        navigationController?.pushViewController(ProfileViewContreoller(), animated: true)
    }
    
    @objc private func goOnBonusViewController() {
        navigationController?.pushViewController(BonusViewController(), animated: true)
    }
}
