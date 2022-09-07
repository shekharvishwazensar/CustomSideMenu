//
//  ViewController.swift
//  SideMenuExampleApp
//
//  Created by SV59349 on 26/08/22.
//

import UIKit
import SideMenuDrawer


class SideMenuDrawerViewController: UIViewController {
    
    @IBOutlet weak var menuView: SideMenuView!
    
    var objMainViewController = MainViewController()
    var drawerItemSelectionCallMeBack: ((_ row: Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.cellHighlightedColor = .gray
        menuView.delegate = self
        menuView.cellHight = 50
        
        menuView.menu = [SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "Music"),
        SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Movies"),
        SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "Books"),
        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings")]
        
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 30)! ]
        menuView.headerTitle =  NSAttributedString(string: "Zensar", attributes: myAttribute)

    }

}

extension SideMenuDrawerViewController: SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int) {
        self.drawerItemSelectionCallMeBack?(row)
    }
}
