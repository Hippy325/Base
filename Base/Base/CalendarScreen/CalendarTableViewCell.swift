//
//  CalendarTableViewCell.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class CalendarTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textGray
        return label
    }()
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgGray
        return view
    }()
    private lazy var HStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(deviderView)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 39, bottom: 0, right: 39))
    }
    
    private func applyStyle() {
        contentView.backgroundColor = .white
        contentView.addSubview(HStackView, top: 13, bottom: -13, left: 22, right: -18)
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.layer.shadowOpacity = 13
        contentView.layer.shadowOffset = CGSize(width: 5, height: 4)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            deviderView.heightAnchor.constraint(equalToConstant: 20),
            deviderView.widthAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func configurable(title: String) {
        titleLabel.text = title
    }
}
