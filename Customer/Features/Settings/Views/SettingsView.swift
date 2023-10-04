//
//  SettingsView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/4/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                haptics
            }
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}

#Preview {
    SettingsView()
}
