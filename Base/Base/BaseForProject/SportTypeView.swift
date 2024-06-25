//
//  SportTypeView.swift
//  Base
//
//  Created by Тигран Гарибян on 20.06.2024.
//

import UIKit

final class SportTypeView: UIView {
    
    private lazy var arrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var current: String?
    var closure: ((String) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .bgGray
        addSubview(arrowIcon)
        addSubview(label)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            label.leftAnchor.constraint(equalTo: arrowIcon.rightAnchor, constant: 10),
            arrowIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            arrowIcon.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 9),
            arrowIcon.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    @objc func tap() {
        guard let current = current else { return }
        closure?(current)
    }
    
    func rotateArrow() {
        UIView.animate(withDuration: 0.35) {
            self.arrowIcon.transform = self.arrowIcon.transform.rotated(by: .pi)
        }
    }
    
    func configure(title: String, isHaveArrow: Bool = false) {
        current = title
        label.text = title
        arrowIcon.isHidden = !isHaveArrow
    }
}
