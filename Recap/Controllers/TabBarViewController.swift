//
//  TabBarViewController.swift
//  Recap
//
//  Created by admin70 on 05/11/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tab1 = FamilyMainScreenViewController()
        let tab2 = ArticleTableViewController()
        
        tab1.title = "Home"
        tab2.title = "Articles"
        
        tab1.navigationItem.largeTitleDisplayMode = .always
        tab2.navigationItem.largeTitleDisplayMode = .always
        
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        nav1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        nav2.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(systemName: "doc.text"), tag: 1)
        nav2.tabBarItem.selectedImage = UIImage(systemName: "doc.text.fill")
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        tabBar.tintColor = .label
        
        setViewControllers ([nav1, nav2], animated: false)


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
