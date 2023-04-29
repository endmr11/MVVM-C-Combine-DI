//
//  Scaledimage.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//


import SwiftUI

struct ScaledImageView: View {
    let name: String
    var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
    }
}
