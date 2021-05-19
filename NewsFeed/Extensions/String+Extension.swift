//
//  String+Extension.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: String(self.prefix(19)))
    }
}
