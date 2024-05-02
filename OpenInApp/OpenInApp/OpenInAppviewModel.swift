//
//  OpenInAppviewModel.swift
//  OpenInApp
//
//  Created by Lalitha Korlapu on 01/05/24.
//

import Foundation

struct LocationItems {
    var icon: String
    var title: String
    var description: String
}

class OpenInAppViewModel: ObservableObject {
    @Published var items:[LocationItems] = [LocationItems(icon: "avatar", title: "", description: ""),LocationItems(icon: "", title: "", description: ""),LocationItems(icon: "globe", title: "", description: "")]
    @Published var isTopTapped: Bool = true
    @Published var isRecentTapped: Bool = false
    @Published var dashboardModel:DashboardModel?
    @Published var recentLinks:[Link] = []
    @Published var topLinks:[Link] = []
    
    public func greetUserOnTime() -> String {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        var greeting: String = ""
        
        switch hourInt {
        case 0..<12:
            greeting = "Good Morning, "
        case 12..<17:
            greeting = "Good AfterNoon, "
        default:
            greeting = "Good Evening, "
        }
        return greeting
    }
    
    func getTopAndRecentLinksData() {
        // Define your URL
        let urlString = "https://api.inopenapp.com/api/v1/dashboardNew"
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }

        // Create a URLRequest
        var request = URLRequest(url: url)

        // Add authorization header
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Create a URLSession task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Check if response is valid
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid response")
                return
            }
            
            // Check if data is available
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            // Decode JSON data
            do {
                let json = try JSONDecoder().decode(DashboardModel.self, from: data) // try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                DispatchQueue.main.async {
                    self.dashboardModel = json
                    self.topLinks = self.dashboardModel?.data?.topLinks ?? []
                    self.recentLinks = self.dashboardModel?.data?.recentLinks ?? []
                    
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }

        // Start the URLSession task
        task.resume()
    }
}
