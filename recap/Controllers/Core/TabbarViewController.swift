//
//  TabbarViewController.swift
//  recap
//
//  Created by Diptayan Jash on 03/11/24.
//

import UIKit

class TabbarViewController: UITabBarController , UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
        let tab1 = HomeViewController()
        let tab2 = FamilyViewController()
        
        tab1.title = "Home"
        tab2.title = "Family"
        
        tab1.navigationItem.largeTitleDisplayMode = .always
        tab2.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Family", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        tabBar.tintColor = .label
        setViewControllers([nav1, nav2], animated: true)
        
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
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
#Preview(){
    TabbarViewController()
}
