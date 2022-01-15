//
//  Numeric+Extensions.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 15/01/22.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
//        formatter.groupingSeparator = ","
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
