//
//  DaysView.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import UIKit

final class DayView: UIView {
    
    private lazy var dayText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Iceland-Regular", size: 23)
        label.text = "DAY"
        return label
    }()
    private lazy var dayNumberText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "\(day)"
        label.textAlignment = .center
        label.font = UIFont(name: "Iceland-Regular", size: 25)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.addArrangedSubview(dayText)
        stackView.addArrangedSubview(dayNumberText)
        return stackView
    }()
    
    let day: Int
    let isActive: Bool
    
    init(day: Int, isActive: Bool) {
        self.day = day
        self.isActive = isActive
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        backgroundColor = isActive ? .bgGreen : .bgGray
        addSubview(stackView, top: 10, bottom: -15, left: 12, right: -12)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 76),
            heightAnchor.constraint(equalToConstant: 71),
        ])
    }
}
