//
//  ContentView.swift
//  OpenInApp
//
//  Created by Lalitha Korlapu on 30/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: OpenInAppViewModel
    @State var index = 0
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HeaderView()
                VStack {
                    ScrollView {
                        DashboardSubView(viewModel: viewModel)
                    }
                    .padding(.bottom, 40)
                }
                .background(ColorPalette.backgroundColor.color)
                .cornerRadius(20)
                .edgesIgnoringSafeArea(.all)
                .padding(.top, -75)
            }.padding(.bottom, 20)
            CustomTabs(index: $index)
                .background(.white)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getTopAndRecentLinksData()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            HStack {
                Text("Dashboard")
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Image(uiImage: UIImage(named: "settings") ?? UIImage())
                    }
                    .padding()
                }
                .background(.blue.opacity(0.5))
                .cornerRadius(8)
            }
            .padding(EdgeInsets(top: 50, leading: 15, bottom: 15, trailing: 15))
        }
        .background(.blue)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct DashboardSubView: View {
    @StateObject var viewModel: OpenInAppViewModel
    var body: some View {
            VStack(spacing: 15) {
                GreetingView(viewModel: viewModel)
                AnalyticsView(viewModel: viewModel)
                TopAndRecentLinks(viewModel: viewModel)
                WhatsAppAndQueries(viewModel: viewModel)
            }.padding()
    }
}

struct GreetingView: View {
    @StateObject var viewModel: OpenInAppViewModel
    let months: [String] = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(viewModel.greetUserOnTime()) ")
                .foregroundColor(.gray.opacity(0.5))
            HStack {
                Text("Ajay Manva")
                Image(uiImage: UIImage(named: "hand") ?? UIImage())
            }
            VStack {
                HStack {
                    Text("Overview")
                        .foregroundColor(.gray.opacity(0.5))
                    Spacer()
                    HStack {
                        HStack {
                            Text("22 Aug - 23 Sept")
                            Image(uiImage: UIImage(named: "clock") ?? UIImage())
                                .resizable()
                                .frame(width: 25, height: 25)
                        }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(Color.gray.opacity(0.25)))
                    
                }.padding()
//                if let data = viewModel.dashboardModel?.data?.overallURLChart {
//                    LineChartView(data: data.map { (time, value) in Double(value) },
//                                  title: "Hourly Data",
//                                  legend: "Data",
//                                  form: ChartForm.extraLarge)
//                    .padding()
//                }
                if let data = viewModel.dashboardModel?.data?.overallURLChart {
                    HourlyLineChart(data: Array(data.values), labels: Array(data.keys))
                        .padding()
                }
            }
            .background(.white)
            .cornerRadius(8)
        }
    }
}

struct AnalyticsView: View {
    @StateObject var viewModel: OpenInAppViewModel
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        HStack {
                            VStack {
                                Image(uiImage: UIImage(named: "avatar") ?? UIImage())
                                Text("\(viewModel.dashboardModel?.todayClicks ?? 0)")
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("Today’s clicks")
                            }.padding()
                        }
                        .background(.white)
                        .cornerRadius(8)
                        HStack {
                            VStack {
                                Image(uiImage: UIImage(named: "location") ?? UIImage())
                                Text(viewModel.dashboardModel?.topLocation ?? "")
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("Top Location")
                            }.padding()
                        }
                        .background(.white)
                        .cornerRadius(8)
                        HStack {
                            VStack {
                                Image(uiImage: UIImage(named: "globe") ?? UIImage())
                                Text(viewModel.dashboardModel?.topSource ?? "")
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("Top source")
                            }.padding()
                        }
                        .background(.white)
                        .cornerRadius(8)
                    }
                }
            }
            HStack {
                Image(uiImage: UIImage(named: "analytics") ?? UIImage())
                Text("View Analytics")
                    .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(Color.gray.opacity(0.25)))
            .background(.white)
        }
    }
}

struct TopAndRecentLinks:View {
    @StateObject var viewModel: OpenInAppViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.isTopTapped = true
                    viewModel.isRecentTapped = false
                } label: {
                    Text("Top Links")
                        .foregroundColor(viewModel.isTopTapped ? .white : .gray.opacity(0.5))
                        .padding()
                }
                .background(viewModel.isTopTapped ? .blue : .clear)
                .cornerRadius(30)
                Button {
                    viewModel.isTopTapped = false
                    viewModel.isRecentTapped = true
                } label: {
                    Text("Recent Links")
                        .foregroundColor(viewModel.isRecentTapped ? .white : .gray.opacity(0.5))
                        .padding()
                }
                .background(viewModel.isRecentTapped ? .blue : .clear)
                .cornerRadius(30)
                Spacer()
                Button {
                    
                } label: {
                    Image(uiImage: UIImage(named: "search") ?? UIImage())
                }
            }
            if viewModel.isTopTapped {
                if viewModel.topLinks.count > 0 {
                    ForEach(viewModel.topLinks.indices, id: \.self){index in
                        LinksData(viewModel: viewModel, link: viewModel.topLinks[index])
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("No Data Found")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            if viewModel.isRecentTapped {
                if viewModel.recentLinks.count > 0 {
                    ForEach(viewModel.recentLinks.indices, id: \.self){index in
                        LinksData(viewModel: viewModel, link: viewModel.recentLinks[index])
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("No Data Found")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct LinksData: View {
    @StateObject var viewModel: OpenInAppViewModel
    var link:Link
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    AsyncImage(
                        url: URL(string: link.originalImage ?? ""),
                        content: { image in
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                        },
                        placeholder: {
                            
                        }
                    )
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(Color.gray.opacity(0.75)))
                    VStack {
                        Text(link.app ?? "")
                        let formattedValue = link.createdAt?.toDate(pattern: DateFormatter.dMMMMyyyyHmm)?.toString(pattern: DateFormatter.dMMMMyyyyHmm) ?? ""
                        Text(formattedValue)
                    }
                    Spacer()
                    VStack {
                        Text("\(link.totalClicks ?? 0)")
                        Text("Clicks")
                    }
                }.padding()
                HStack {
                    Text(link.webLink ?? "")
                        .foregroundColor(.blue)
                        .padding()
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(uiImage: UIImage(named: "copy") ?? UIImage())
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .background(.blue.opacity(0.1))
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(.blue)
                    }
                )
               
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            }
        }
        .background(.white)
        .cornerRadius(5)
    }
}

struct WhatsAppAndQueries: View {
    @StateObject var viewModel: OpenInAppViewModel
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(uiImage: UIImage(named: "attach") ?? UIImage())
                Text("View all Links")
                    .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(Color.gray.opacity(0.25)))
            .background(.white)
            HStack {
                Image(uiImage: UIImage(named: "whatsApp") ?? UIImage())
                    .padding(.leading, 10)
                Text("Talk with us")
                    .padding()
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(ColorPalette.greenColor.color))
            .background(ColorPalette.greenColor.color.opacity(0.1))
            .padding(.top, 15)
            HStack {
                Image(uiImage: UIImage(named: "analytics") ?? UIImage())
                    .padding(.leading, 10)
                Text("Frequently Asked Questions")
                    .padding()
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.6).fill(ColorPalette.blueColor.color))
            .background(ColorPalette.blueColor.color.opacity(0.1))
        }
    }
}

struct CustomTabs: View {
    @Binding var index: Int
    var body: some View {
            HStack {
                Button {
                    self.index = 0
                } label: {
                    Image(uiImage: UIImage(named: "attach") ?? UIImage())
                }
                .foregroundColor(index == 0 ? .black : .gray)
                Spacer()
                Button {
                    self.index = 1
                } label: {
                    Image(uiImage: UIImage(named: "course") ?? UIImage())
                }
                .foregroundColor(index == 1 ? .black : .gray)
                .offset(x: 10)
                Spacer()
                Button {
                    
                } label: {
                    Image(uiImage: UIImage(named: "add") ?? UIImage())
                        .renderingMode(.original)
                }
                .offset(y: -15)
                Spacer()
                Button {
                    self.index = 2
                } label: {
                    Image(uiImage: UIImage(named: "campaign") ?? UIImage())
                }
                .foregroundColor(index == 2 ? .black : .gray)
                .offset(x: -10)
                Spacer()
                Button {
                    self.index = 3
                } label: {
                    Image(uiImage: UIImage(named: "profile") ?? UIImage())
                }
                .foregroundColor(index == 3 ? .black : .gray)
            }.frame(height: 30)
            .background(.white)
    }
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 25))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x:  rect.width, y: 25))
            path.addArc(center: CGPoint(x: (rect.width/2) + 4, y: 25), radius: 25, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
        }
    }
}
