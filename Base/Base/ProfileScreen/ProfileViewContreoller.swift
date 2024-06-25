//
//  ProfileViewContreoller.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class ProfileViewContreoller: UIViewController {
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel = TitleView()
    private lazy var sportTypeView = SportTypeView()
    private lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("CANCEL", for: .normal)
        button.backgroundColor = .bgRed
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(tapOnOk), for: .touchUpInside)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 9
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(cancleButton)
        stackView.addArrangedSubview(okButton)
        return stackView
    }()
    private lazy var nameTextField: BaseTextField = {
        let view = BaseTextField()
        view.titleLabel.text = "Name"
        view.textField.text = UserDefaults.standard.string(forKey: "profileName")
        return view
    }()
    private lazy var bioView: InfoTextField = {
        let view = InfoTextField()
        view.titleLabel.text = "BIO"
        view.textView.text = UserDefaults.standard.string(forKey: "profileBio")
        return view
    }()
    private lazy var achievementsView: InfoTextField = {
        let view = InfoTextField()
        view.titleLabel.text = "ACHIEVEMENTS"
        view.textView.text = UserDefaults.standard.string(forKey: "profileAchievements")
        return view
    }()
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 36
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(bioView)
        stackView.addArrangedSubview(achievementsView)
        return stackView
    }()
    private let settingsView = SettingsView()
    
    private var settingsOppened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(topView)
        view.addSubview(titleLabel)
        view.addSubview(sportTypeView)
        view.addSubview(stackView)
        view.addSubview(fieldsStackView)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = "Profile"
        sportTypeView.configure(title: "")
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            sportTypeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            sportTypeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sportTypeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            fieldsStackView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor, constant: 41),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            fieldsStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -40),
            bioView.heightAnchor.constraint(equalTo: achievementsView.heightAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            settingsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func settingsViewAction() {
        if settingsOppened {
            titleLabel.button.setImage(UIImage(named: "titileButtonIcon"), for: .normal)
        } else {
            titleLabel.button.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        UIView.animate(withDuration: 0.3) {
            if self.settingsOppened {
                self.settingsView.alpha = 0
                self.settingsOppened = false
            } else {
                self.settingsView.alpha = 1
                self.settingsOppened = true
            }
        }
    }
    
    @objc private func tapOnOk() {
        UserDefaults.standard.setValue(nameTextField.textField.text, forKey: "profileName")
        UserDefaults.standard.setValue(bioView.textView.text, forKey: "profileBio")
        UserDefaults.standard.setValue(achievementsView.textView.text, forKey: "profileAchievements")
        navigationController?.popToRootViewController(animated: true)
    }
}
