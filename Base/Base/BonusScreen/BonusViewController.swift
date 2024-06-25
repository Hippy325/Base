//
//  BonusViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import UIKit

final class BonusViewController: UIViewController {
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel = TitleView()
    private lazy var sportTypeView = SportTypeView()
    private let settingsView = SettingsView()
    private let daysBonusView = DaysBonusView()
    private let chooseBonusView = ChooseBonusView()
    
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
        view.addSubview(daysBonusView)
        view.addSubview(chooseBonusView)
        view.addSubview(settingsView)
        chooseBonusView.closure = { [weak self] in
            self?.goOnMainViewController()
        }
        daysBonusView.okButton.addTarget(self, action: #selector(goOnMainViewController), for: .touchUpInside)
        daysBonusView.grabButton.addTarget(self, action: #selector(goOnMainViewController), for: .touchUpInside)
        if BonusModel.getDays().count >= 7 {
            daysBonusView.isHidden = true
            chooseBonusView.isHidden = false
        } else {
            daysBonusView.isHidden = false
            chooseBonusView.isHidden = true
        }
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = "Bonus"
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
            daysBonusView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor),
            daysBonusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            daysBonusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            daysBonusView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chooseBonusView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor),
            chooseBonusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chooseBonusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chooseBonusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func goOnMainViewController() {
        navigationController?.popToRootViewController(animated: true)
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
}
