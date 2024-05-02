//
//  HourlyLineChart.swift
//  OpenInApp
//
//  Created by Lalitha Korlapu on 01/05/24.
//

import Foundation
import SwiftUI

struct HourlyLineChart: View {
    let data: [Int]
    let labels: [String]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background grid lines
                ForEach(1..<6) { i in
                    Path { path in
                        let y = geometry.size.height / 6 * CGFloat(i)
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5, dash: [4]))
                }

                // Data line
                Path { path in
                    for i in 0..<self.data.count {
                        let x = CGFloat(i) / CGFloat(self.data.count - 1) * geometry.size.width
                        let y = (1 - CGFloat(self.data[i]) / CGFloat(self.data.max() ?? 1)) * geometry.size.height
                        if i == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 2)

                // X-axis labels
                ForEach(0..<self.labels.count, id: \.self) { i in
                    Text(self.labels[i])
                        .position(x: CGFloat(i) / CGFloat(self.labels.count - 1) * geometry.size.width, y: geometry.size.height + 8)
                        .font(.caption)
                }

                // Y-axis labels
                ForEach(0..<6) { i in
                    Text("\(i * 20)")
                        .position(x: -16, y: geometry.size.height - CGFloat(i) * geometry.size.height / 5)
                        .font(.caption)
                }
            }
        }
        .padding()
        .frame(height: 200)
    }
}

struct HourlyLineCharts: View {
    let data: [String: Int]
    let hours: [String]
    let maxValue: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background grid lines
                ForEach(1..<7) { i in
                    Path { path in
                        let y = geometry.size.height / CGFloat(7) * CGFloat(i)
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5, dash: [4]))
                }
                
                // Data line
                Path { path in
                    for i in 0..<self.hours.count {
                        let hour = self.hours[i]
                        let value = CGFloat(self.data[hour] ?? 0)
                        let x = CGFloat(i) / CGFloat(self.hours.count - 1) * geometry.size.width
                        let y = (1 - value / CGFloat(6)) * geometry.size.height
                        if i == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
                
                // X-axis labels
                ForEach(0..<self.hours.count, id: \.self) { i in
                    Text(self.hours[i])
                        .position(x: CGFloat(i) / CGFloat(self.hours.count - 1) * geometry.size.width, y: geometry.size.height + 8)
                        .font(.caption)
                }
                
                // Y-axis labels
                ForEach(0..<6) { i in
                    Text("\(i)")
                        .position(x: -16, y: geometry.size.height - CGFloat(i) * geometry.size.height / CGFloat(6))
                        .font(.caption)
                }
            }
        }
        .padding()
        .frame(height: 200)
    }
}
