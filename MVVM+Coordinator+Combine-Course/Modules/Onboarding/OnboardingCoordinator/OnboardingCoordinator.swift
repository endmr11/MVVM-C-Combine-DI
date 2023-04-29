//
//  OnboardingCoordinator.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import Foundation
import SwiftUI
import Combine

class OnboardingCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    var hasSeenOnboarding: CurrentValueSubject<Bool, Never>
    
    init(hasSeenOnboarding: CurrentValueSubject<Bool, Never>) {
        self.hasSeenOnboarding = hasSeenOnboarding
    }
    
    func start() {
        let view = OnboardingView { [weak self] in
            print("done has been called")
            self?.hasSeenOnboarding.send(true)
        }
        rootViewController = UIHostingController(rootView: view)
    }
}
