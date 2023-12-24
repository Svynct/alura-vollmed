//
//  Date+.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 24/12/23.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
