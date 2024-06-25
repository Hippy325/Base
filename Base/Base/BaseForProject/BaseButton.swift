//
//  BaseButton.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class BaseButton: UIButton {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 13
        layer.shadowOffset = CGSize(width: 5, height: 4)
        addSubview(textLabel)
        addSubview(deviderView)
        
        NSLayoutConstraint.activate([
            deviderView.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            deviderView.widthAnchor.constraint(equalToConstant: 2),
            deviderView.heightAnchor.constraint(equalToConstant: 17),
            deviderView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            deviderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
        ])
    }
}
