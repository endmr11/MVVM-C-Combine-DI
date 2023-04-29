//
//  SignUpCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import Foundation
import UIKit

class SignUpExampleCoordinator:Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var signUpExampleViewController: SignUpViewController = {
        let vc = SignUpViewController()
        vc.title = "SignUp Example"
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([signUpExampleViewController], animated: false)
    }
}
