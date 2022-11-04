//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Alexander Korchak on 03.11.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    private let cellID = "tableCellIdentifier"
    var habit: Habit!
    
    private lazy var activityTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityTable)
        navigationItem.title = habit.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(goToEdit))
        
        NSLayoutConstraint.activate([
        
            activityTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            activityTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            activityTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])

    }
    
    @objc func goToEdit() {
        let viewController = HabitViewController()
        viewController.habit = habit
        viewController.hidesBottomBarWhenPushed = true
        viewController.habitState = .edit
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let date = HabitsStore.shared.dates[indexPath.item]
        cell.textLabel?.text = date.toString()
        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension Date {
    var dayBefore: Date {
        guard let day = Calendar.current.date(byAdding: .day, value: -1, to: self) else {
           return Date()
        }
       return day
    }
    
    var dayBeforeYesterday: Date {
        guard let day = Calendar.current.date(byAdding: .day, value: -2, to: self) else {
           return Date()
        }
       return day
    }
    
    func get() -> Int {
      Calendar.current.component(.day, from: self)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_Ru")
        formatter.dateFormat = "dd MMMM YYYY"
        
        let date = Date()
        let day = get()
        let today = date.get()
        let yesterday = date.dayBefore.get()
        let dayBeforeYesterday = date.dayBeforeYesterday.get()
        
        switch day {
        case today: return "Сегодня"
        case yesterday: return "Вчера"
        case dayBeforeYesterday: return "Позавчера"
        default: return formatter.string(from: self)
        }
    }
}


