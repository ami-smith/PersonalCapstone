//
//  SettingsView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/24.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("notificationsEnabled") var notificationsEnabled = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                VStack {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Set reminder for creating a new entry")
                    }
                    .padding()
                    .onChange(of: notificationsEnabled) { value in
                        if value {
                            scheduleNotification()
                        } else {
                            cancelNotification()
                        }
                    }
                    Spacer()
                }
            }
            
            .navigationBarTitle("Settings", displayMode: .large)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                Text("Back")
            })
        }
    }
    
    
    func requestAuthorizationAndScheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                scheduleNotification()
            } else if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
            
        }
    }
    
    func scheduleNotification() {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Time to write in your journal!"
        content.body = "Don't forget to take a moment to write in your journal!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func cancelNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
    }
}



    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

