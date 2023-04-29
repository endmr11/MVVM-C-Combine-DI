//
//  TabBarCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import Foundation
import UIKit
import Combine

class TabBarCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    
    var childCoordinators = [Coordinator]()
    
    init() {
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .systemBackground
        initContainer()

//        print(isOn)
//        self.rootViewController.selectedViewController?.view.overrideUserInterfaceStyle = isOn ? .dark : .light
    }
    
    func start() {
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
        let homeViewController = homeCoordinator.rootViewController
        setup(vc: homeViewController,title: "Home",imageName: "house",selectedImageName: "house.fill")
        
        
        let otherExamplesCoordinator = OtherExamplesCoordinator()
        otherExamplesCoordinator.start()
        self.childCoordinators.append(otherExamplesCoordinator)
        let otherExamplesViewController = otherExamplesCoordinator.rootViewController
        setup(vc: otherExamplesViewController,title: "Other Examples",imageName: "star",selectedImageName: "star.fill")
        
        
        self.rootViewController.viewControllers = [homeViewController, otherExamplesViewController]
        
    }
    
    func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
