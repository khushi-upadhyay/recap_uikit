////
////  ReportCollectionViewCell.swift
////  Recap
////
////  Created by admin70 on 05/11/24.
////
//
import UIKit

class RecentReportDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Recent Report"
        
    }
}

//
//import UIKit
//import SwiftUI
//
//class RecentReportDetailViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Recent Report"
//        
//        // Set up the SwiftUI chart in this view controller
//        setupMemoryBarChartView()
//    }
//    
//    private func setupMemoryBarChartView() {
//        // Example data to pass to the SwiftUI view
//        let recentMemoryData: [RecentMemoryData] = [
//            RecentMemoryData(week: "Week 1", correctAnswers: 10, incorrectAnswers: 5),
//            RecentMemoryData(week: "Week 2", correctAnswers: 12, incorrectAnswers: 4),
//            RecentMemoryData(week: "Week 3", correctAnswers: 8, incorrectAnswers: 6),
//            RecentMemoryData(week: "Week 4", correctAnswers: 15, incorrectAnswers: 2)
//        ]
//        
//        // Create the SwiftUI view
//        let memoryBarChartView = MemoryBarChartView(data: recentMemoryData)
//        
//        // Embed it in a UIHostingController
//        let hostingController = UIHostingController(rootView: memoryBarChartView)
//        
//        // Add the hosting controller as a child
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//        
//        // Set up Auto Layout constraints
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//        
//        // Finalize child view controller setup
//        hostingController.didMove(toParent: self)
//    }
//}
