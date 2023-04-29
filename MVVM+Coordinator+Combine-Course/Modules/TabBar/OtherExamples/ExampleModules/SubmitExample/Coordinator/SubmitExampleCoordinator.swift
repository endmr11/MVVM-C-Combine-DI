//
//  SubmitExampleCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import Foundation
import UIKit

class SubmitExampleCoordinator:Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var submitExampleViewController: SubmitExampleViewController = {
        let vc = SubmitExampleViewController()
        vc.title = "Submit Example"
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([submitExampleViewController], animated: false)
    }
}
