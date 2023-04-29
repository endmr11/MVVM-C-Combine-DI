//
//  TabBarManager.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 25.04.2023.
//

import Foundation
import Combine

class TabBarManager {
    var switchState:PassthroughSubject<Bool, Never>
    init(switchState: PassthroughSubject<Bool, Never>) {
        self.switchState = switchState
    }
}
