//
//  DateFormatter.swift
//  OpenInApp
//
//  Created by Lalitha Korlapu on 01/05/24.
//

import Foundation
import SwiftUI
public extension DateFormatter {
    private static let reusableDateFormatter = DateFormatter()
    static let yyyyMMDDZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let dMMMMyyyyHmm = "d MMMM, yyyy  h:mm a"
    static func dateFormatter(forPattern pattern: String) -> DateFormatter {
        DateFormatter.reusableDateFormatter.dateFormat = pattern
        return DateFormatter.reusableDateFormatter
    }
}

public extension String {

//    var boolValue: Bool {
//        return self.lowercased() == "true"
//    }
//
//    var intValue: Int {
//        return Int(self) ?? -1
//    }

    func toDate(pattern: String) -> Date? {
        return DateFormatter.dateFormatter(forPattern: pattern).date(from: self)
    }
}

public extension Date {
    func toString(pattern: String) -> String {
        return DateFormatter.dateFormatter(forPattern: pattern).string(from: self)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RoundedCornerShape: Shape {
    var corner: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height - radius))

        path.addArc(
            center: CGPoint(x: width - radius, y: height - radius),
            radius: radius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )

        if corner.contains(.bottomLeft) {
            path.addLine(to: CGPoint(x: radius, y: height))
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }

        if corner.contains(.topLeft) {
            path.addLine(to: CGPoint(x: 0, y: radius))
            path.addArc(
                center: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }

        return path
    }
}


extension UIView {
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}
