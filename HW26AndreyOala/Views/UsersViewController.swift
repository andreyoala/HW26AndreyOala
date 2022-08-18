//
//  UsersViewController.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 16.08.2022.
//

import UIKit
import CoreData

class UsersViewController: UIViewController {
    
    var data = CoreDataModel()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var textFieldUserName: UITextField = {
        let text = UITextField()
        text.placeholder = "Print your name here"
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 0.25
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.textAlignment = .center
        text.autocorrectionType = .no
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var pressButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitle("Press", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func touchButton() {
        if let text = textFieldUserName.text, text != "" {
            self.data.saveData(name: text, date: nil, gender: nil)
            textFieldUserName.text = ""
        }
        updateTableView()
    }
    
    private func updateTableView() {
        data.fetchData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }
    
    func setupHierarchy() {
        view.addSubview(textFieldUserName)
        view.addSubview(pressButton)
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func setupLayout() {
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
        tableView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            textFieldUserName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            textFieldUserName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldUserName.heightAnchor.constraint(equalToConstant: 50),
            textFieldUserName.widthAnchor.constraint(equalToConstant: 350),
            
            pressButton.centerYAnchor.constraint(equalTo: textFieldUserName.centerYAnchor, constant: 80),
            pressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pressButton.heightAnchor.constraint(equalToConstant: 50),
            pressButton.widthAnchor.constraint(equalToConstant: 350),
        ])
    }
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.deleteData(index: indexPath.row)
            updateTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.people.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UsersProfileViewController()
        let indexPeople = data.people[indexPath.row]
        vc.personPeople = indexPeople
        navigationController?.pushViewController(vc, animated: true)
        vc.textFieldProfile.text = indexPeople.name
        vc.dataPicker.date = indexPeople.dataPicker ?? Date()
        vc.textFieldGender.text = indexPeople.gender
    }
}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = data.people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = person.name
        return cell
    }
}
