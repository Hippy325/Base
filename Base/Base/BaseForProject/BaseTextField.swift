//
//  BaseTextField.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

final class BaseTextField: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textGray
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "editIcon")
        return imageView
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .textGray
        textField.textAlignment = .right
        return textField
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 18
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(imageView)
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
        addSubview(stackView, top: 12, bottom: -12, left: 20, right: -13)
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 12
        layer.shadowOffset = CGSize(width: 5, height: 4)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 16.3),
            imageView.heightAnchor.constraint(equalToConstant: 16.3),
            titleLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
