//
//  SettingsView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/21/24.
//

import SwiftUI
import UserNotifications
import CoreData

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("notificationsEnabled") var notificationsEnabled = false
    @State private var reminderTime: Date?
    @State private var selectedTime: Date = Date()

    var body: some View {
        NavigationView {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
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
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Select Reminder Time")
                                .font(.headline)
                                .padding(.leading)

                            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
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
                        }
                        .padding(.horizontal)
                    } else {
                        Text("No reminder time set.")
                            .padding()
                    }

                    Spacer()
                }
            }
            .navigationBarTitle("Settings", displayMode: .large)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .accentColor(Color("purpleHaze"))
                    Text("Back")
                        .accentColor(Color("purpleHaze"))
                }
            })
            .onAppear {
                reminderTime = UserDefaults.standard.object(forKey: "reminderTime") as? Date
                if let reminderTime = reminderTime {
                    selectedTime = reminderTime
                }
            }
        }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
