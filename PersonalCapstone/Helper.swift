//
//  Helper.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 4/15/24.
//

import Foundation



extension String {
    
    func stringToDate(format: String) -> Date {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let date = dateFormat.date(from: self)!
        return date
    }
}
