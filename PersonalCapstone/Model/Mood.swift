//
//  Mood.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 4/15/24.
//
//
import Foundation
import SwiftUI
import CoreData

enum emotionState: String, Codable {
    case happy
    case meh
    case sad
}

struct Emotion: Codable {
    var state: emotionState
    
    func stringValue() -> String {
        return state.rawValue
    }
    
}

struct Mood: Codable, Equatable, Identifiable {
    var id = UUID()
    let emotion: Emotion
    let date: Date
    
    init(id: UUID, emotion: Emotion, date: Date) {
        self.id = id
        self.emotion = emotion
        self.date = date
    }
    
    var dateString: String {
        dateFormatter.string(from: date)
    }
    var monthString: String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "DDD"
        
        let month = dateFormatter1.string(from: date)
        
        return month
    }
    var dayAsInt: Int {
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    var year: String {
        return Calendar.current.component(.year, from: date).description
    }
    
    static func == (lhs: Mood, rhs: Mood) -> Bool {
        if lhs.date == rhs.date {
            return true
        } else {
            return false
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
