//
//  Detail.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import SwiftUI
import Combine

struct EditView: View {
    @State private var notifyCheck = false
    @ObservedObject var viewModel: HomeViewModel
    var cancellables = Set<AnyCancellable>()
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Text("Edit")
            
            TextField("name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("surname", text: $viewModel.surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Toggle(isOn: $notifyCheck) {
                Text("Switch")
            }.onChange(of: notifyCheck) { value in
                container.resolve(TabBarManager.self)?.switchState.send(value)
            }
        }
        .padding()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(viewModel: HomeViewModel())
    }
}
