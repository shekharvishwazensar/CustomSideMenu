//
//  SettingViewController.swift
//  SideMenuExampleApp
//
//  Created by SV59349 on 01/09/22.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.objMainViewController.gestureEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.objMainViewController.gestureEnabled = true
    }
}
