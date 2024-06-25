//
//  MainViewController.swift
//  Base
//
//  Created by Тигран Гарибян on 18.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
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
        return tableView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
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
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calendar", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowOpacity = 12
        button.layer.shadowOffset = CGSize(width: 5, height: 4)
        button.titleLabel?.font = UIFont(name: "Iceland-Regular", size: 21)
        button.addTarget(self, action: #selector(calendarAction), for: .touchUpInside)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(newMatchButton)
        stackView.addArrangedSubview(newEventButton)
        return stackView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 9
        stackView.distribution = .fill
        stackView.addArrangedSubview(buttonsStackView)
        stackView.addArrangedSubview(calendarButton)
        return stackView
    }()
    private let settingsView = SettingsView(true)
    
    private var settingsOppened = false
    var models: [EventModel] = EventsModel.getEvents()
    private var allSports = SportsModel.getAllTypeSports()
    private var selectedSport = "All Sports"
    private var isOpenedTypes = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                UserDefaults.standard.setValue(true, forKey: "notifications")
            } else {
                UserDefaults.standard.setValue(false, forKey: "notifications")
            }
        }
        setupUI()
        navigationController?.pushViewController(BonusViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allSports = SportsModel.getAllTypeSports()
        sportTypeTableView.reloadData()
        models = EventsModel.getEvents()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .bg
        view.addSubview(topView)
        view.addSubview(titleLabel)
        view.addSubview(sportTypeView)
        view.addSubview(tableView)
        view.addSubview(sportTypeTableView)
        view.addSubview(stackView)
        view.addSubview(settingsView)
        
        titleLabel.button.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        settingsView.closure = { self.settingsViewAction() }
        settingsView.navigationController = navigationController
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
            tableView.topAnchor.constraint(equalTo: sportTypeView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            settingsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func selectNewTypeSport() {
        if selectedSport == "All Sports" {
            models = EventsModel.getEvents()
        } else {
            models = EventsModel.getEvents().filter({
                $0.sportName == selectedSport
            })
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
    
    @objc private func calendarAction() {
        navigationController?.pushViewController(CalendarViewController(), animated: true)
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == sportTypeTableView {
            return 20
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sportTypeTableView {
            return allSports.count
        }
        return models.count + 1
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
        if indexPath.row == models.count {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            return cell
        } else {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell
            else { return UITableViewCell() }
            cell.configurable(models[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == sportTypeTableView { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == sportTypeTableView { return }
        if editingStyle == .delete {
            print("Deleted")
            EventsModel.removeEvent(index: indexPath.row)
            models.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sportTypeTableView {
            selectedSport = allSports[indexPath.row]
            sportTypeView.configure(title: selectedSport, isHaveArrow: true)
            openTypes()
            selectNewTypeSport()
            return
        }
        if indexPath.row != models.count {
            navigationController?.pushViewController(NewEventViewController(index: indexPath.row), animated: true)
        }
    }
}
