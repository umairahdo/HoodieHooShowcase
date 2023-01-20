//
//  TabBarController.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabBarItems()
    }

    private func configureTabBarItems() {
        
        self.tabBarController?.tabBar.accessibilityIdentifier = AccessibilityIdentifiers.tabBar
        
        let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageList")
        listVC.tabBarItem = UITabBarItem(title: "Image List", image: UIImage(systemName: "1.circle"), tag: 0)
        listVC.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.imageListTab

        let lastSelectedImageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lastSelected") as! LastSelectedVC
        lastSelectedImageVC.index = 1
        lastSelectedImageVC.tabBarItem = UITabBarItem(title: "Last Selected Image", image: UIImage(systemName: "2.circle"), tag: 1)
        lastSelectedImageVC.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.lastSelectedImageTab
        
        let secondLastSelectedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lastSelected") as! LastSelectedVC
        secondLastSelectedVC.index = 2
        secondLastSelectedVC.tabBarItem = UITabBarItem(title: "Second Last Selected Image", image: UIImage(systemName: "3.circle"), tag: 2)
        secondLastSelectedVC.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.secondLastSelectedImageTab

        let listNavigationVC = UINavigationController(rootViewController: listVC)
        let lastSelectedImageNavigationVC = UINavigationController(rootViewController: lastSelectedImageVC)
        let secondLastSelectedNavigationVC = UINavigationController(rootViewController: secondLastSelectedVC)
        
        setViewControllers([listNavigationVC, lastSelectedImageNavigationVC, secondLastSelectedNavigationVC], animated: false)
    }
}
