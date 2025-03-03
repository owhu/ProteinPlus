//
//  MainView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 2/28/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Main", systemImage: "house")
                }
            ChartView()
                .tabItem {
                    Label("History", systemImage: "chart.bar.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
