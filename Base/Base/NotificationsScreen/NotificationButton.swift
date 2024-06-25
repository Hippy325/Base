//
//  NotificationButton.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class NotificationButton: UIButton {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.text = "NOTIFICATIONS"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
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
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 14
        layer.shadowOffset = CGSize(width: 6, height: 4)
        addSubview(textLabel)
        addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            rightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -27),
            rightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
        ])
    }
    
    func configure(isActive: Bool) {
        if isActive {
            textLabel.textColor = .textGray
            rightLabel.textColor = .textGray
        } else {
            textLabel.textColor = .enableGray
            rightLabel.textColor = .enableGray
        }
    }
}
