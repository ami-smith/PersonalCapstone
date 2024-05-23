//
//  ReminderSettingsView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 5/2/24.
//

import SwiftUI
import UserNotifications

struct ReminderSettingsView: View {
    @Binding var notificationsEnabled: Bool
    @State private var reminderTime: Date?
    @State private var selectedTime: Date
    
    init(notificationsEnabled: Binding<Bool>) {
        _notificationsEnabled = notificationsEnabled
        _selectedTime = State(initialValue: UserDefaults.standard.object(forKey: "reminderTime") as? Date ?? Date())
    }
    
    var body: some View {
        VStack {
            Toggle(isOn: $notificationsEnabled) {
                Text("Enable Reminders")
            }
            .padding()
            .onChange(of: notificationsEnabled) { value in
                if value {
                    requestAuthorizationAndScheduleNotification()
                } else {
                    cancelNotification()
                }
            }
            
            if notificationsEnabled {
                DatePicker("Select Reminder Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    .onChange(of: selectedTime) { newTime in
                        reminderTime = newTime
                        updateNotification(at: newTime)
                        UserDefaults.standard.set(newTime, forKey: "reminderTime")
                    }
                
                if let reminderTime = reminderTime {
                    Text("Reminder set for: \(formattedTime(reminderTime))")
                        .padding()
                } else {
                    Text("No reminder time set.")
                        .padding()
                }
            } else {
                Text("No reminder time set.")
                    .padding()
            }
            
            Spacer()
        }
        .onAppear {
            reminderTime = UserDefaults.standard.object(forKey: "reminderTime") as? Date
        }
        .navigationTitle("Reminder Settings")
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func requestAuthorizationAndScheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                if let reminderTime = reminderTime {
                    updateNotification(at: reminderTime)
                }
            } else if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }
    
    private func scheduleNotification(at date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Time to write in your journal!"
        content.body = "Don't forget to take a moment to write in your journal!"
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "JournalReminder", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    private func updateNotification(at date: Date) {
        cancelNotification() // Remove previous notification
        scheduleNotification(at: date) // Schedule new notification
    }
    
    private func cancelNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["JournalReminder"])
    }
}

struct ReminderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderSettingsView(notificationsEnabled: .constant(false))
    }
}
