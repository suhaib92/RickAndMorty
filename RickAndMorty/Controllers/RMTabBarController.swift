//
//  ViewController.swift
//  RickAndMorty
//
//  Created by suhaib alfaouri on 15/12/2024.
//

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        selectedIndex = 2
   //     self.tabBar.frame.height = 50
     
    }
    private  func setUpTabBar() {
        let locationVC = RMLocationViewController()
        let charactersVC = RMCharacterViewController()
        let episodesVC = RMEspisodeViewController()
        let settingsVC = RMSettingViewController()
        locationVC.title = "Location"
        charactersVC.title = "Character"
        episodesVC.title = "Episodes"
        settingsVC.title = "Settings"
        let nav1 = UINavigationController(rootViewController: locationVC)
        let nav2 = UINavigationController(rootViewController: charactersVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        
        nav1.tabBarItem = UITabBarItem(title: locationVC.title, image: UIImage(systemName: "globe"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: charactersVC.title, image: UIImage(systemName: "person"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: episodesVC.title, image: UIImage(systemName: "tv"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: settingsVC.title, image: UIImage(systemName: "gearshape"), tag: 3)
        
        for nav in  [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        tabBar.frame.size.height = 60
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setInductor(index: tabBar.selectedItem!.tag , tabBarController: self)
    }
    func setInductor (index : Int , tabBarController : UITabBarController) {
        self.tabBar.selectedImageTintColor = .orange
        let tabBar = tabBarController.tabBar
        for subview in tabBarController.view.subviews {
                  if subview.tag == 100 {
                      subview.removeFromSuperview()
                  }
              }
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: 20))
        customView.backgroundColor = UIColor.black
        customView.tag = 100

        let tabBarFrame = tabBar.frame
        let tabBarItemWidth = tabBarFrame.width / CGFloat(tabBar.items?.count ?? 1)
        let xOffset = tabBarItemWidth * CGFloat(index) + 3.5
        let yOffset = tabBarFrame.origin.y - 1

        customView.frame = CGRect(x: xOffset, y: yOffset, width: 3, height: 3)

        tabBarController.view.addSubview(customView)

        UIView.animate(withDuration: 1,
                       delay: 0.0,
                       usingSpringWithDamping: 3,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
                           customView.frame = CGRect(x: xOffset, y: yOffset, width: tabBarItemWidth - 10, height: 2)
                       }, completion: nil)
   
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBar.layer.borderWidth = 0.17
        setInductor(index: selectedIndex, tabBarController: self)
    }
}

