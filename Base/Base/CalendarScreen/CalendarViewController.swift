//
//  CalendarViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel = TitleView()
    private lazy var sportTypeView = SportTypeView()
    private lazy var sportTypeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .bgGray
        tableView.alpha = 0
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "CalendarTableViewCell")
        return tableView
    }()
    private lazy var newMatchButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Match", for: .normal)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.addTarget(self, action: #selector(newEventAction), for: .touchUpInside)
        return button
    }()
    private lazy var newEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("New EVENT", for: .normal)
        button.backgroundColor = .bgGray
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.addTarget(self, action: #selector(newEventAction), for: .touchUpInside)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(newMatchButton)
        stackView.addArrangedSubview(newEventButton)
        return stackView
    }()
    private let settingsView = SettingsView()
    
    private var settingsOppened = false
    private var models = CalendarDays.getClandarForEvents(sport: "All Sports")
    private var allSports = SportsModel.getAllTypeSports()
    private var selectedSport = "All Sports"
    private var isOpenedTypes = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allSports = SportsModel.getAllTypeSports()
        sportTypeTableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(topView)
        view.addSubview(titleLabel)
        view.addSubview(sportTypeView)
        view.addSubview(tableView)
        view.addSubview(buttonsStackView)
        view.addSubview(sportTypeTableView)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.navigationController = navigationController
        titleLabel.titleLabel.text = "Calendar"
        sportTypeView.configure(title: selectedSport, isHaveArrow: true)
        sportTypeView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openTypes))
        )
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            sportTypeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            sportTypeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sportTypeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sportTypeTableView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor),
            sportTypeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sportTypeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sportTypeTableView.heightAnchor.constraint(equalToConstant: 250),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            tableView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func selectNewTypeSport() {
        if selectedSport == "All Sports" {
            models = CalendarDays.getClandarForEvents(sport: "All Sports")
        } else {
            models = CalendarDays.getClandarForEvents(sport: selectedSport)
        }
        UIView.transition(
            with: tableView,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: { self.tableView.reloadData() }
        )
    }
    
    @objc private func openTypes() {
        if (isOpenedTypes) {
            UIView.animate(withDuration: 0.2) {
                self.sportTypeTableView.alpha = 0
            }
            isOpenedTypes = false
        } else {
            UIView.animate(withDuration: 0.2) {
                self.sportTypeTableView.alpha = 1
            }
            isOpenedTypes = true
        }
    }
    
    @objc private func newEventAction() {
        navigationController?.pushViewController(NewEventViewController(), animated: true)
    }
    
    @objc private func settingsViewAction() {
        if settingsOppened {
            titleLabel.button.setImage(UIImage(named: "titileButtonIcon"), for: .normal)
        } else {
            titleLabel.button.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        UIView.animate(withDuration: 0.3) {
            if self.settingsOppened {
                self.settingsView.alpha = 0
                self.settingsOppened = false
            } else {
                self.settingsView.alpha = 1
                self.settingsOppened = true
            }
        }
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sportTypeTableView {
            return 20
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == sportTypeTableView {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == sportTypeTableView {
            return nil
        }
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == sportTypeTableView {
            return 1
        }
        return models.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sportTypeTableView {
            return allSports.count
        }
        return models.count <= section ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sportTypeTableView {
            let cell = UITableViewCell()
            cell.textLabel?.text = allSports[indexPath.row]
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 19)
            cell.selectionStyle = .none
            return cell
        }
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as? CalendarTableViewCell
        else { return UITableViewCell() }
        cell.configurable(title: models[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sportTypeTableView {
            selectedSport = allSports[indexPath.row]
            sportTypeView.configure(title: selectedSport, isHaveArrow: true)
            openTypes()
            selectNewTypeSport()
            return
        }
        navigationController?.pushViewController(
            NewEventViewController(index: CalendarDays.getEventIndexFromDate(monthName: models[indexPath.section])), 
            animated: true
        )
    }
}
