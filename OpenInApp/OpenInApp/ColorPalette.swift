//
//  ColorPalette.swift
//  OpenInApp
//
//  Created by Lalitha Korlapu on 01/05/24.
//

import Foundation
import SwiftUI

enum ColorPalette: String {
    case backgroundColor
    case blueColor
    case greenColor
}

extension ColorPalette {
    var color: Color {
        Color(self.rawValue)
    }
}

