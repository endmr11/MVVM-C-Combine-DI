//
//  ApplicationCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import SwiftUI
import UIKit
import Combine

protocol IMainCoordinator{
    func setupOnboardingValue()
}

class MainCoordinator:Coordinator{
    let window: UIWindow
    var childCoordinators = [Coordinator]()
    let hasSeenOnboarding = CurrentValueSubject<Bool,Never>(false)
    var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupOnboardingValue()
        hasSeenOnboarding
            .removeDuplicates()
            .sink { [weak self] hasSeen in
            if hasSeen {
                let tabBarCoordinator = TabBarCoordinator()
                tabBarCoordinator.start()
                self?.childCoordinators = [tabBarCoordinator]
                self?.window.rootViewController = tabBarCoordinator.rootViewController
            } else if let hasSeenOnboarding = self?.hasSeenOnboarding {
                let onboardingCoordinator = OnboardingCoordinator(hasSeenOnboarding: hasSeenOnboarding)
                onboardingCoordinator.start()
                self?.childCoordinators = [onboardingCoordinator]
                self?.window.rootViewController = onboardingCoordinator.rootViewController
            }
        }
        .store(in: &subscriptions)
    }
    
}


extension MainCoordinator:IMainCoordinator{
    func setupOnboardingValue() {
        let key = "hasSeenOnboarding"
        let value = UserDefaults.standard.bool(forKey: key)
        hasSeenOnboarding.send(value)
        
        hasSeenOnboarding
            .filter({ $0 })
            .sink { (value) in
                UserDefaults.standard.setValue(value, forKey: key)
            }
            .store(in: &subscriptions)
    }
}
