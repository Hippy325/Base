//
//  NewEventViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

final class NewEventViewController: UIViewController {
    
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
        return view
    }()
    private lazy var sportTextField: BaseTextField = {
        let view = BaseTextField()
        view.titleLabel.text = "Sport"
        return view
    }()
    private lazy var dateTextField: BaseTextField = {
        let view = BaseTextField()
        view.titleLabel.text = "Date"
        view.textField.attributedPlaceholder = NSAttributedString(
            string: "01.01.24 12:30",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
//        view.textField.keyboardType = .numberPad
        return view
    }()
    private let infoView = InfoTextField()
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(sportTextField)
        stackView.addArrangedSubview(dateTextField)
        return stackView
    }()
    private let settingsView = SettingsView()
    
    private var settingsOppened = false
    private let index: Int?
    
    init(index: Int? = nil) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(infoView)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = "New Event"
        sportTypeView.configure(title: "")
        
        if let index = index {
            let event = EventsModel.getEvents()[index]
            nameTextField.textField.text = event.title
            sportTextField.textField.text = event.sportName
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy h:mm"
            dateTextField.textField.text = dateFormatter.string(from: event.date)
            infoView.textView.text = event.description
        }
        
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
            infoView.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 32),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 39),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39),
            infoView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -23),
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
        if nameTextField.textField.text == nil || nameTextField.textField.text == "" {
            showAlert("All fields are required", andAlertMessage: "Fill in the name field")
            return
        }
        if sportTextField.textField.text == nil || sportTextField.textField.text == "" {
            showAlert("All fields are required", andAlertMessage: "Fill in the sport field")
            return
        }
        if dateTextField.textField.text == nil || dateTextField.textField.text == "" {
            showAlert("All fields are required", andAlertMessage: "Fill in the date field")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy hh:mm"
        guard let date = dateFormatter.date(from: dateTextField.textField.text!) else {
            showAlert("Invalid date")
            return
        }
        if infoView.textView.text == nil || infoView.textView.text == "" {
            showAlert("All fields are required", andAlertMessage: "Fill in the info field")
            return
        }
        if let index = index {
            EventsModel.removeEvent(index: index)
            EventsModel.addEvent(
                EventModel(
                    date: date,
                    title: nameTextField.textField.text!,
                    sportName: sportTextField.textField.text!,
                    description: infoView.textView.text
                )
            )
            back()
        } else {
            EventsModel.addEvent(
                EventModel(
                    date: date,
                    title: nameTextField.textField.text!,
                    sportName: sportTextField.textField.text!,
                    description: infoView.textView.text
                )
            )
            back()
        }
    }
}
