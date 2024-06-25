//
//  TitleView.swift
//  Base
//
//  Created by Тигран Гарибян on 20.06.2024.
//

import UIKit

final class TitleView: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "titileButtonIcon"), for: .normal)
        return button
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sport Tracker"
        label.font = UIFont(name: "GrandHotel-Regular", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        backgroundColor = .bgRed
        addSubview(button)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 19),
            button.heightAnchor.constraint(equalToConstant: 14.5),
        ])
    }
}
