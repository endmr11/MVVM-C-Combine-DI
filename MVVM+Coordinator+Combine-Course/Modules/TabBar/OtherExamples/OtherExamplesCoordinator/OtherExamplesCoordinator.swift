//
//  SettingsCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import Foundation
import UIKit

class OtherExamplesCoordinator:Coordinator {
    
    var rootViewController = UINavigationController()
    var childCoordinators = [Coordinator]()
    lazy var otherExamplesViewController: OtherExamplesViewController = {
        let vc = OtherExamplesViewController()
        vc.didSelectRowAt = { [weak self] index in
            switch index{
            case 0:
                print("SimpleExample")
                let simpleExampleCoordinator = SimpleExampleCoordinator()
                simpleExampleCoordinator.start()
                self?.childCoordinators = [simpleExampleCoordinator]
                let simpleExampleViewController = simpleExampleCoordinator.rootViewController.viewControllers.first
                self?.rootViewController.pushViewController(simpleExampleViewController!, animated: true)
            case 1:
                print("SubmitExample")
                let submitExampleCoordinator = SubmitExampleCoordinator()
                submitExampleCoordinator.start()
                self?.childCoordinators = [submitExampleCoordinator]
                let simpleExampleViewController = submitExampleCoordinator.rootViewController.viewControllers.first
                self?.rootViewController.pushViewController(simpleExampleViewController!, animated: true)
            case 2:
                print("SignUpExample")
                let signUpExampleCoordinator = SignUpExampleCoordinator()
                signUpExampleCoordinator.start()
                self?.childCoordinators = [signUpExampleCoordinator]
                let signUpExampleViewController = signUpExampleCoordinator.rootViewController.viewControllers.first
                self?.rootViewController.pushViewController(signUpExampleViewController!, animated: true)
            default:
                return
            }
        }
        vc.title = "Other Examples"
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([otherExamplesViewController], animated: false)
    }
}
