//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexander Korchak on 27.10.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    enum Offset: CGFloat {
        case leftPadding = 16
    }
    
    private var habit: Habit!
    private var onStateButtonClick: (() -> Void)!
    
    static let identifier = "HabitId"
    
    private let checkedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withRenderingMode(.alwaysTemplate)
    private let uncheckedImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withRenderingMode(.alwaysTemplate)
    
    private lazy var stateButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickOnStateButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func clickOnStateButton() {
        if !habit.isAlreadyTakenToday {
            stateButton.setImage(checkedImage, for: .normal)
            HabitsStore.shared.track(habit)
            onStateButtonClick()
        }
    }
    
    private lazy var habitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupElements()
    }
    
    func setupElements() {
        self.contentView.addSubview(habitLabel)
        self.contentView.addSubview(scheduleLabel)
        self.contentView.addSubview(counter)
        self.contentView.addSubview(stateButton)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
        
            habitLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            habitLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Offset.leftPadding.rawValue),
            habitLabel.bottomAnchor.constraint(equalTo: self.scheduleLabel.topAnchor, constant: -8),
            
            
            scheduleLabel.topAnchor.constraint(equalTo: self.habitLabel.bottomAnchor, constant: 8),
            scheduleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Offset.leftPadding.rawValue),
            scheduleLabel.bottomAnchor.constraint(equalTo: self.counter.topAnchor, constant: -30),
            
            counter.topAnchor.constraint(equalTo: self.scheduleLabel.bottomAnchor, constant: 30),
            counter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Offset.leftPadding.rawValue),
            counter.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            stateButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            stateButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stateButton.widthAnchor.constraint(equalToConstant: 38),
            stateButton.heightAnchor.constraint(equalToConstant: 38),
         
        ])
    }
    
    func setupCell(with habit: Habit, onStateButtonClick: @escaping () -> Void) {
        self.habit = habit
        self.onStateButtonClick = onStateButtonClick
        self.habitLabel.text = habit.name
        self.habitLabel.textColor = habit.color
        self.scheduleLabel.text = habit.dateString
        self.counter.text = "Счётчик: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday {
            self.stateButton.setImage(checkedImage, for: .normal)
        } else {
            self.stateButton.setImage(uncheckedImage, for: .normal)
        }
        self.stateButton.tintColor = habit.color
    }
}
