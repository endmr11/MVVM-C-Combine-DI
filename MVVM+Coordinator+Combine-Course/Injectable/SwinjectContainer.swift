//
//  SwinjectContainer.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 25.04.2023.
//

import Foundation
import Swinject
import Combine

let container = Container()
func initContainer(){
    container.register(TabBarManager.self) { _ in TabBarManager(switchState: PassthroughSubject<Bool, Never>()) }.inObjectScope(.container)
}

