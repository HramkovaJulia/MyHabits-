//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Artyom Prima on 03.11.2022.
//

import UIKit

class HabitViewController: UIViewController,  UITextFieldDelegate {
    
    let store = HabitsStore.shared

    var didAppendHabit: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navItem = UINavigationItem(title: "Создать")
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        navItem.rightBarButtonItem = saveItem
        saveItem.tintColor = .purple
        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector (save))
        navItem.leftBarButtonItem = cancelItem
        
        view.backgroundColor = .white
        addSubviews()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    private var labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.numberOfLines = 1
        labelTitle.textAlignment = .left
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = "НАЗВАНИЕ"
        labelTitle.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelTitle
        
    }()
    
    private var textFieldTitle: UITextField = {
        let textFieldTitle = UITextField()
        textFieldTitle.textColor = .blue
        textFieldTitle.placeholder = "Бегать по утрам спать 8 часов и т.п."
        textFieldTitle.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textFieldTitle.returnKeyType = .done
        //        textFieldTitle.delegate = self
        return textFieldTitle
    }()
    
    private var labelColor: UILabel = {
        let labelColor = UILabel()
        labelColor.numberOfLines = 1
        labelColor.translatesAutoresizingMaskIntoConstraints = false
        labelColor.text = "ЦВЕТ"
        labelColor.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelColor
    }()
    
    private var labelTime: UILabel = {
        let labelTime = UILabel()
        labelTime.numberOfLines = 1
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.text = "ВРЕМЯ"
        labelTime.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return labelTime
    }()
    
    private var labelTimeForDate: UILabel = {
        let labelTime = UILabel()
        labelTime.numberOfLines = 1
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.text = "Каждый день в "
        labelTime.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return labelTime
    }()
    
    private lazy var buttonColor: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonColorChoose), for: .touchUpInside)
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.tintColor = #colorLiteral(red: 0.6329703331, green: 0.08420988172, blue: 0.8011942506, alpha: 1)
        datePicker.datePickerMode = .time
        datePicker.backgroundColor = .white
        datePicker.accessibilityIgnoresInvertColors = false
        datePicker.contentHorizontalAlignment = .center
        
        return datePicker
    }()
    
    let stackView:  UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.contentMode = .scaleAspectFill
        stackView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackViewDate: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .scaleAspectFill
        stackView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    @objc func buttonColorChoose() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.supportsAlpha = false
        present(colorPickerVC, animated: true)
        
    }
    
    func addSubviews() {
        navigationItem.title = "Создать"
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveItem
        saveItem.tintColor = .purple
        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector (save))
        navigationItem.leftBarButtonItem = cancelItem
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(textFieldTitle)
        stackView.addArrangedSubview(labelColor)
        stackView.addArrangedSubview(buttonColor)
        stackView.addArrangedSubview(labelTime)
        stackView.addArrangedSubview(stackViewDate)
        
        stackViewDate.addArrangedSubview(labelTimeForDate)
        stackViewDate.addArrangedSubview(datePicker)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFieldTitle.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func handleTap() {
        self.view.endEditing(true)
    }
    
    @objc func save() {
        print(#function)
        print("СОЗДАНИЕ НОВОЙ ПРИВЫЧКИ")
        
        let habit = Habit(name: textFieldTitle.text!,
                          date: datePicker.date,
                          color: buttonColor.backgroundColor!)
        store.habits.append(habit)
        navigationController?.navigationBar.prefersLargeTitles = true
        didAppendHabit?()
    
    }
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        
        buttonColor.backgroundColor = color
    }
}



