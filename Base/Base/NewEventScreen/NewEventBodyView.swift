//
//  NewEventBodyView.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

final class NewEventBodyView: UIView {
    
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
//        view.textField.keyboardType = .numberPad
        return view
    }()
    private let infoView = InfoTextField()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(sportTextField)
        stackView.addArrangedSubview(dateTextField)
        stackView.addArrangedSubview(infoView)
        return stackView
    }()
    
    private func setup() {
        addSubview(stackView, top: 0)
    }
    
}
