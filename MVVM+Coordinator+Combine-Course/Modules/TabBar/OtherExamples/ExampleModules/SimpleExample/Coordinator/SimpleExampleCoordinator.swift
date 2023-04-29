//
//  SimpleExampleCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import Foundation
import UIKit

class SimpleExampleCoordinator:Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var simpleExampleViewController: SimpleExampleViewController = {
        let vc = SimpleExampleViewController()
        vc.title = "Simple Example"
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([simpleExampleViewController], animated: false)
    }
}
