//
//  MainTabBarViewController.swift
//  MyHabits
//
//  Created by Alexander Korchak on 25.10.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "Purple")

        let homeViewController = UINavigationController(rootViewController: HabitsViewController())
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        
        homeViewController.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        homeViewController.tabBarItem.title = "Привычки"
        homeViewController.navigationBar.prefersLargeTitles = true
        homeViewController.navigationBar.backgroundColor = .white
        
        infoViewController.tabBarItem.image = UIImage(systemName: "info.circle")
        infoViewController.tabBarItem.title = "Информация"
        infoViewController.navigationBar.prefersLargeTitles = true
        infoViewController.navigationBar.backgroundColor = .white
        
        setViewControllers([homeViewController, infoViewController], animated: true)
    }
  
}
