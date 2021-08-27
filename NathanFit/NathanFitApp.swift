//
//  NathanFitApp.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/26.
//

import SwiftUI

@main
struct NathanFitApp: App {
    @StateObject private var historyStore: HistoryStore
    @State private var showAlert = false
    
    init() {
        let historyStore: HistoryStore
        do {
            historyStore = try HistoryStore(withChecking: true)
        } catch {
            print("Could not load history data")
            historyStore = HistoryStore()
            showAlert = true
        }
        _historyStore = StateObject(wrappedValue: historyStore)
    }
    
    var body: some Scene {
        let docuURL = FileManager.default
        WindowGroup {
            ContentView()
                .environmentObject(historyStore)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("History"),
                        message: Text(
                        """
                        Unfortunately we can't load your past history.
                        Email support : hajinopro@gmail.com
                        """),
                        dismissButton: .none)
                }
                .onAppear {
                    print("\(docuURL.urls(for: .documentDirectory, in: .userDomainMask))")
                }
        }
    }
}
