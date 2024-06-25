//
//  InfoTextField.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

final class InfoTextField: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Info"
        label.textColor = .textGray
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "editIcon")
        return imageView
    }()
    lazy var textView: UITextView = {
        let view = UITextView()
        view.textColor = .textGray
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView())
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        addSubview(textView)
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 12
        layer.shadowOffset = CGSize(width: 5, height: 4)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            textView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 3),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            imageView.widthAnchor.constraint(equalToConstant: 16.3),
            imageView.heightAnchor.constraint(equalToConstant: 16.3),
        ])
    }
}
