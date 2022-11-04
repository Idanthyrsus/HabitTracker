//
//  HabitListViewController.swift
//  MyHabits
//
//  Created by Alexander Korchak on 01.11.2022.
//

import UIKit

enum HabitViewControllerState {
    case create, edit
}

class HabitViewController: UIViewController, UITextFieldDelegate {
    
    var habit: Habit?
    var habitState: HabitViewControllerState = .create
    var guide: UILayoutGuide!
    
    private var currentTitle: String = ""
    private var currentColor: UIColor = .orange
    private var currentDate: Date = Date()
    private let picker = UIColorPickerViewController()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, учиться, читать по 50 страниц в день и т. д."
        textField.text = currentTitle
        textField.delegate = self
        return textField
    }()
    
    private lazy var colorButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        let customImage = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withRenderingMode(.alwaysTemplate)
        button.setImage(customImage, for: .normal)
        button.tintColor = currentColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  
    func setTextDatePicker(with value: String) {
        let mutableString = NSMutableAttributedString(string: "Каждый день в \(value)")
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "Purple")!, range: NSRange(location: 12, length: value.count + 2))
        self.datePickerLabel.attributedText = mutableString
    }
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(setCurrentTime(_:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc func setCurrentTime(_ sender: UIDatePicker) {
        self.currentDate = sender.date
        setTextDatePicker(with: sender.date.formatted(date: .omitted, time: .shortened))
    }
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit!.name)?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive){ _ in
            HabitsStore.shared.habits.removeAll { $0 == self.habit }
            let viewController = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(viewController[viewController.count - 3], animated: true)
        })
        self.present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        
        if let habit {
            currentDate = habit.date
            currentColor = habit.color
            currentTitle = habit.name
        }
        
        setupElements()
        setupNavigationControllerAppearance()
    }
    
    func setupNavigationControllerAppearance() {
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.title = self.habitState == .create ? "Создать" : "Править"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveHabit(_ sender: UIBarButtonItem) {
                if self.habitState == .create {
                    HabitsStore.shared.habits.append(
                    Habit(name: currentTitle, date: currentDate, color: currentColor)
                    )
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let h = HabitsStore.shared.habits.first {
                        $0 == habit
                    }
                    if let h = h {
                        h.name = currentTitle
                        h.date = currentDate
                        h.color = currentColor
                    }
                    let vcs = self.navigationController!.viewControllers
                    self.navigationController?.popToViewController(vcs[vcs.count-3], animated: true)
                }
            }
    
    @objc private func showPicker() {
        picker.delegate = self
        self.present(picker, animated: true)
    }

    func setupElements() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(titleTextField)
        self.view.addSubview(colorButtonLabel)
        self.view.addSubview(colorButton)
        self.view.addSubview(dateLabel)
        self.view.addSubview(datePickerLabel)
        self.view.addSubview(datePicker)
        self.view.addSubview(deleteHabitButton)
        let dateString = currentDate.formatted(date: .omitted, time: .shortened)
        setTextDatePicker(with: dateString)
        
        if habitState == .edit {
            self.view.addSubview(deleteHabitButton)
        }
        self.picker.selectedColor = currentColor
        
        guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            titleTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 16),
            
            colorButtonLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            colorButtonLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
            colorButton.topAnchor.constraint(equalTo: colorButtonLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
            datePickerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            datePickerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            
            deleteHabitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deleteHabitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
            
        ])
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.currentTitle = textField.text ?? ""
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.currentColor = color
        colorButton.tintColor = color
    }
    

}
