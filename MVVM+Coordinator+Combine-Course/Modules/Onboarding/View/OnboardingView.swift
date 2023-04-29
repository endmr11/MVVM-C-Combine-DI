//
//  OnboardingView.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    var doneCallbackFn: () -> ()
    
    var body: some View {
        TabView {
            
            ScaledImageView(name: "car")
                .tag(0)
            ScaledImageView(name: "car")
                .tag(1)
            ScaledImageView(name: "car")
                .tag(2)
            
            Button("Done") {
                doneCallbackFn()
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color(UIColor.systemBackground)
            .ignoresSafeArea(.all))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(doneCallbackFn: { })
    }
}
