//
//  MainTableViewCell.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .textGray
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "asdada"
        label.textColor = .textGray
        return label
    }()
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(timeLabel)
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .textGray
        return label
    }()
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.addArrangedSubview(dateStackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.alignment = .center
        return stackView
    }()
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgGray
        return view
    }()
    private lazy var sportNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .right
        label.textColor = .textGray
        return label
    }()
    private lazy var HStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(deviderView)
        stackView.addArrangedSubview(sportNameLabel)
        return stackView
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .bgGray
        view.addSubview(descriptionLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 18, bottom: 0, right: 18))
    }
    
    private func applyStyle() {
        contentView.backgroundColor = .white
        contentView.addSubview(descriptionBackgroundView)
        contentView.addSubview(HStackView)
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.layer.shadowOpacity = 13
        contentView.layer.shadowOffset = CGSize(width: 5, height: 4)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            descriptionBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            descriptionBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 9),
            descriptionBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -9),
            descriptionBackgroundView.heightAnchor.constraint(equalToConstant: 24),
            HStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            HStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            HStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            deviderView.heightAnchor.constraint(equalToConstant: 20),
            deviderView.widthAnchor.constraint(equalToConstant: 2),
            sportNameLabel.widthAnchor.constraint(equalToConstant: 110),
            descriptionLabel.centerYAnchor.constraint(equalTo: descriptionBackgroundView.centerYAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: descriptionBackgroundView.leftAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: descriptionBackgroundView.rightAnchor, constant: -5)
        ])
    }
    
    func configurable(_ model: EventModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm"
        dateLabel.text = dateFormatter.string(from: model.date)
        timeLabel.text = timeFormatter.string(from: model.date)
        titleLabel.text = model.title
        sportNameLabel.text = model.sportName
        descriptionLabel.text = model.description
    }
}
