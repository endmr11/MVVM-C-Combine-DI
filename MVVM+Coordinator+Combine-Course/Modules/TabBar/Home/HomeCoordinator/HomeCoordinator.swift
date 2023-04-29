//
//  HomeCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import Foundation

import UIKit
import SwiftUI

class HomeCoordinator: NSObject, Coordinator {
    
    var rootViewController: UINavigationController
    
    let viewModel = HomeViewModel()
    
    override init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        super.init()
        
        rootViewController.delegate = self
    }
    
    lazy var homeViewController: HomeViewController = {
       let vc = HomeViewController()
        vc.viewModel = viewModel
        vc.showDetailRequested = { [weak self] in
            self?.goToDetail()
        }
        vc.title = "Home"
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
    }
    
    func goToDetail() {
        let editViewController = UIHostingController(rootView: EditView(viewModel: viewModel))
        rootViewController.pushViewController(editViewController, animated: true)
    }
}

extension HomeCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,willShow viewController: UIViewController,animated: Bool) {
        
        if viewController as? UIHostingController<EditView> != nil {
            print("detail will be shown")
        } else if viewController as? HomeViewController != nil {
            print("first will be shown")
        }
    }
}
