//
//  UsersProfileViewController.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 16.08.2022.
//

import UIKit
import CoreData

class UsersProfileViewController: UIViewController {
    
    var personPeople: Person?
    
    var data = CoreDataModel()
    
    var isEdit = false
    
    let genderType = ["Male", "Female", "Others"]
    
    lazy var randomAvatars: [UIImage?] = [
        UIImage(systemName: "airplane"),
        UIImage(systemName: "car.fill"),
        UIImage(systemName: "bus.fill"),
        UIImage(systemName: "tram.fill"),
        UIImage(systemName: "ferry.fill"),
        UIImage(systemName: "scooter")
    ]
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = randomAvatars.randomElement() as? UIImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var photoItem: UIImageView = {
        let item = UIImageView(image: UIImage(systemName: "person"))
        return item
    }()
    
    lazy var photoCalendar: UIImageView = {
        let item = UIImageView(image: UIImage(systemName: "calendar"))
        return item
    }()
    
    lazy var photoGender: UIImageView = {
        let item = UIImageView(image: UIImage(systemName: "person.2"))
        return item
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 70
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var textFieldProfile: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = ""
        nameField.isUserInteractionEnabled = false
        nameField.autocorrectionType = .no
        nameField.textAlignment = .left
        nameField.backgroundColor = .systemGray6
        nameField.setIcon(UIImage(systemName: "person.crop.circle")!)
        nameField.layer.cornerRadius = 8
        nameField.clearsOnBeginEditing = true
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }()
    
    lazy var textFieldGender: UITextField = {
        let genderField = UITextField()
        genderField.setIcon(UIImage(systemName: "person.2.circle")!)
        genderField.textAlignment = .left
        genderField.placeholder = "Chouse your gender"
        genderField.backgroundColor = .systemGray6
        genderField.layer.cornerRadius = 8
        genderField.clearsOnBeginEditing = true
        genderField.isUserInteractionEnabled = false
        genderField.translatesAutoresizingMaskIntoConstraints = false
        return genderField
    }()
    
    lazy var dataPicker: UIDatePicker = {
        let data = UIDatePicker()
        data.date = .now
        data.datePickerMode = .date
        data.isUserInteractionEnabled = false
        data.translatesAutoresizingMaskIntoConstraints = false
        return data
    }()
    
    lazy var genderPicker: UIPickerView = {
        let gender = UIPickerView()
        gender.isUserInteractionEnabled = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        let birtdayField = UITextField()
        birtdayField.setIcon(UIImage(systemName: "calendar")!)
        birtdayField.textAlignment = .left
        birtdayField.textColor = .systemGray2
        birtdayField.backgroundColor = .systemGray6
        birtdayField.inputView = gender
        birtdayField.layer.cornerRadius = 8
        birtdayField.clearsOnBeginEditing = true
        birtdayField.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    lazy var birthDayField: UITextField = {
        let birtdayField = UITextField()
        birtdayField.setIcon(UIImage(systemName: "calendar")!)
        birtdayField.textAlignment = .left
        birtdayField.textColor = .systemGray2
        birtdayField.backgroundColor = .systemGray6
        birtdayField.layer.cornerRadius = 8
        birtdayField.clearsOnBeginEditing = true
        birtdayField.translatesAutoresizingMaskIntoConstraints = false
        birtdayField.isUserInteractionEnabled = false
        return birtdayField
    }()

    @objc func addTapped() {
        navigationItem.rightBarButtonItem?.title = isEdit ? "Edit" : "Save"
        if (isEdit) {
            personPeople?.name = textFieldProfile.text
            personPeople?.dataPicker = dataPicker.date
            personPeople?.gender = textFieldGender.text
            data.updateProfile()
        }
        isEdit.toggle()
        textFieldProfile.isUserInteractionEnabled = isEdit
        dataPicker.isUserInteractionEnabled = isEdit
        genderPicker.isUserInteractionEnabled = isEdit
        textFieldGender.isUserInteractionEnabled = isEdit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addTapped))
        genderPicker.dataSource = self
        genderPicker.delegate = self
        textFieldGender.inputView = genderPicker
        title = textFieldProfile.text
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
    }
    
    func setupHierarchy() {
        view.addSubview(avatarImage)
        view.addSubview(stackView)
        view.addSubview(textFieldProfile)
        view.addSubview(birthDayField)
        view.addSubview(dataPicker)
        view.addSubview(textFieldGender)
    }
    
    func setupLayout() {
        
//        stackView.addArrangedSubview(photoItem)
//        stackView.addArrangedSubview(photoGender)
//        stackView.addArrangedSubview(photoCalendar)
        
        NSLayoutConstraint.activate([
            
            avatarImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 200),
            avatarImage.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: 300),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -170),
            
            textFieldProfile.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: -90),
            textFieldProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            textFieldProfile.widthAnchor.constraint(equalToConstant: 350),
            textFieldProfile.heightAnchor.constraint(equalToConstant: 50),
            
            dataPicker.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 50),
            dataPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -65),
            
            
            textFieldGender.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: -20),
            textFieldGender.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            textFieldGender.widthAnchor.constraint(equalToConstant: 350),
            textFieldGender.heightAnchor.constraint(equalToConstant: 50),
            
            birthDayField.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 50),
            birthDayField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            birthDayField.widthAnchor.constraint(equalToConstant: 350),
            birthDayField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension UsersProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldGender.text = genderType[row]
        textFieldGender.resignFirstResponder()
    }
}
