//
//  ViewController.swift
//  MyHabits
//
//  Created by Alexander Korchak on 25.10.2022.
//

import UIKit


class HabitsViewController: UIViewController {

    private var store = HabitsStore.shared

    private lazy var habitsCollection: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenSize.width - 32, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: screenSize.width, height: 60)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collection.backgroundColor = UIColor(named: "Background")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProgressHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProgressHeaderView.identifier)
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        setupNavigationBar()
        setupCollection()
        store.habits.removeAll()
        store.habits.append(Habit(name: "Wake up", date: Date(), color: .purple))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.habitsCollection.reloadData()
    }

    private func setupNavigationBar() {

        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateHabit(_:)))
    }

    @objc func goToCreateHabit(_ sender: UIButton) {
        let viewController = HabitViewController()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }


    private func setupCollection() {

        self.view.addSubview(habitsCollection)
        self.habitsCollection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        NSLayoutConstraint.activate([
            habitsCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            habitsCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            habitsCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            habitsCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }

        cell.setupCell(with: store.habits[indexPath.item]) {
            self.habitsCollection.reloadData()
        }
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProgressHeaderView.identifier, for: indexPath) as! ProgressHeaderView
        header.setupProgress(with: store.todayProgress)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = HabitDetailsViewController()
        viewController.habit = store.habits[indexPath.item]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

