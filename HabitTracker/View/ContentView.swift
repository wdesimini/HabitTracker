//
//  ContentView.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataManager = DataManager.shared
    
    var body: some View {
        Form {
            Section(header: Text("User")) {
                Text(username)
            }
            Section(header: Text("Habit Tracks")) {
                HabitTracksList()
            }
        }
    }
    
    var user: User? {
        dataManager.usersDataService.objectsById.values.first
    }
    
    var username: String {
        user?.username ?? "No User"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
