//
//  SettingsViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel = TitleView()
    private lazy var sportTypeView = SportTypeView()
    private lazy var profileButton: BaseButton = {
        let view = BaseButton()
        view.textLabel.text = "MY Profile"
        view.addTarget(self, action: #selector(tapOnProfile), for: .touchUpInside)
        return view
    }()
    private lazy var notificationsButton: BaseButton = {
        let view = BaseButton()
        view.textLabel.text = "NOTIFICATIONS"
        view.addTarget(self, action: #selector(tapOnNotifications), for: .touchUpInside)
        return view
    }()
    private lazy var privacyPolicyButton: BaseButton = {
        let view = BaseButton()
        view.textLabel.text = "PRIVACY POLICY"
        view.addTarget(self, action: #selector(tapOnPolicy), for: .touchUpInside)
        return view
    }()
    private lazy var aboutButton: BaseButton = {
        let view = BaseButton()
        view.textLabel.text = "ABOUT APP"
        view.addTarget(self, action: #selector(tapOnAbout), for: .touchUpInside)
        return view
    }()
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(profileButton)
        stackView.addArrangedSubview(notificationsButton)
        stackView.addArrangedSubview(privacyPolicyButton)
        stackView.addArrangedSubview(aboutButton)
        return stackView
    }()
    private let settingsView = SettingsView()
    
    private var settingsOppened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(topView)
        view.addSubview(titleLabel)
        view.addSubview(sportTypeView)
        view.addSubview(fieldsStackView)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = "Settings"
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
            fieldsStackView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor, constant: 37),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39),
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
    
    @objc private func tapOnProfile() {
        navigationController?.pushViewController(ProfileViewContreoller(), animated: true)
    }
    
    @objc private func tapOnNotifications() {
        navigationController?.pushViewController(NotificationsViewController(), animated: true)
    }
    
    @objc private func tapOnAbout() {
        navigationController?.pushViewController(TextViewController(), animated: true)
    }
    
    @objc private func tapOnPolicy() {
        navigationController?.pushViewController(TextViewController(titleText: "Privacy Policy", isAboutApp: false), animated: true)
    }
}
