//
//  DashboardModel.swift
//  OPenInApp
//
//  Created by Lalitha Korlapu on 01/05/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dashboardModel = try? JSONDecoder().decode(DashboardModel.self, from: jsonData)

import Foundation

// MARK: - DashboardModel
struct DashboardModel: Codable {
    let status: Bool?
    let statusCode: Int?
    let message, supportWhatsappNumber: String?
    let extraIncome: Double?
    let totalLinks, totalClicks, todayClicks: Int?
    let topSource, topLocation, startTime: String?
    let linksCreatedToday, appliedCampaign: Int?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case supportWhatsappNumber = "support_whatsapp_number"
        case extraIncome = "extra_income"
        case totalLinks = "total_links"
        case totalClicks = "total_clicks"
        case todayClicks = "today_clicks"
        case topSource = "top_source"
        case topLocation = "top_location"
        case startTime
        case linksCreatedToday = "links_created_today"
        case appliedCampaign = "applied_campaign"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let recentLinks, topLinks, favouriteLinks: [Link]?
    let overallURLChart: [String: Int]?

    enum CodingKeys: String, CodingKey {
        case recentLinks = "recent_links"
        case topLinks = "top_links"
        case favouriteLinks = "favourite_links"
        case overallURLChart = "overall_url_chart"
    }
}

// MARK: - Link
struct Link: Codable {
    let urlID: Int?
    let webLink: String?
    let smartLink, title: String?
    let totalClicks: Int?
    let originalImage: String?
    let thumbnail, timesAgo, createdAt, domainID: String?
    let urlPrefix: String?
    let urlSuffix, app: String?
    let isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case urlID = "url_id"
        case webLink = "web_link"
        case smartLink = "smart_link"
        case title
        case totalClicks = "total_clicks"
        case originalImage = "original_image"
        case thumbnail
        case timesAgo = "times_ago"
        case createdAt = "created_at"
        case domainID = "domain_id"
        case urlPrefix = "url_prefix"
        case urlSuffix = "url_suffix"
        case app
        case isFavourite = "is_favourite"
    }
}
