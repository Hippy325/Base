//
//  TextViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class TextViewController: UIViewController {
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel = TitleView()
    private lazy var sportTypeView = SportTypeView()
    
    private let settingsView = SettingsView()
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.textColor = .textGray
        textView.font = .systemFont(ofSize: 15)
        textView.text = isAboutApp ? "aboutText".localized : "policyText".localized
        return textView
    }()
    private lazy var backgroundTextView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.shadowOpacity = 14
        view.layer.shadowOffset = CGSize(width: 6, height: 4)
        view.addSubview(textView, top: 22, left: 17, right: -17)
        return view
    }()
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 14
        button.layer.shadowOffset = CGSize(width: 6, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 23)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private var settingsOppened = false
    private let titleText: String
    private let isAboutApp: Bool
    
    init(titleText: String = "About App", isAboutApp: Bool = true) {
        self.titleText = titleText
        self.isAboutApp = isAboutApp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(topView)
        view.addSubview(titleLabel)
        view.addSubview(sportTypeView)
        view.addSubview(backgroundTextView)
        view.addSubview(okButton)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = titleText
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
            backgroundTextView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor, constant: 16),
            backgroundTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backgroundTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backgroundTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            okButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 35),
            okButton.widthAnchor.constraint(equalToConstant: 172),
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
}
