//
//  ExtensionDate.swift
//  WeatherTest
//
//  Created by Polina on 28.03.2022.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
