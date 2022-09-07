//
//  MainViewController.swift
//  SideMenuExampleApp
//
//  Created by SV59349 on 26/08/22.
//

import UIKit
import SideMenuDrawer

class SideMenuMainViewController: UIViewController {
    
    private var sideMenuViewController: SideMenuDrawerViewController!
    private var sideMenuShadowView: UIView!
    var objMainViewController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSideMenu()
    }
    
    func setUpSideMenu() {
        objMainViewController.mainViewController = self
        
        // Navigation Bar Appearance
        // self.setNavBarAppearance(tintColor: .white, barColor: UIColor.magenta)
        
        self.setMenuBackgroundShadow()
        
        // Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuID") as? SideMenuDrawerViewController
        //        self.sideMenuViewController.defaultHighlightedCell = 0 // Default Highlighted Cell
        view.insertSubview(self.sideMenuViewController!.view, at: objMainViewController.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        
        self.sideMenuViewController!.didMove(toParent: self)
        
        // Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if objMainViewController.revealSideMenuOnTop {
            objMainViewController.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -objMainViewController.sideMenuRevealWidth - objMainViewController.paddingForRotation)
            objMainViewController.sideMenuTrailingConstraint.isActive = true
        }
        
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: objMainViewController.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
        
        objMainViewController.sideMenuShadowView = sideMenuShadowView
        
        // Default Main View Controller
        objMainViewController.showViewController(viewController: UINavigationController.self, mainViewController: self, storyboard: "Main", storyboardId: "HomeNavID")
        
        sideMenuViewController.drawerItemSelectionCallMeBack = { (item) -> Void in
            self.selectedCell(item)
        }
    }
    
    func setMenuBackgroundShadow() {
        // Shadow Background View
        sideMenuShadowView = UIView(frame: self.view.bounds)
        sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sideMenuShadowView.backgroundColor = .black
        sideMenuShadowView.alpha = 0.0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if objMainViewController.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
    }
    
    //    func setNavBarAppearance(tintColor: UIColor, barColor: UIColor) {
    //        let appearance = UINavigationBarAppearance()
    //        appearance.configureWithOpaqueBackground()
    //        appearance.backgroundColor = barColor
    //        appearance.titleTextAttributes = [.foregroundColor: tintColor]
    //        UINavigationBar.appearance().standardAppearance = appearance
    //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    //        UINavigationBar.appearance().isTranslucent = false
    //        UINavigationBar.appearance().tintColor = tintColor
    //    }
    
    
    // Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    @IBAction open func revealSideMenu() {
        objMainViewController.sideMenuState(expanded: objMainViewController.isExpanded ? false : true)
    }
    
    
}

extension SideMenuMainViewController {
    func selectedCell(_ row: Int) {
        
        
        //  let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //            let profileModalVC = storyboard.instantiateViewController(withIdentifier: "ProfileModalID") as? ProfileViewController
        //            present(profileModalVC!, animated: true, completion: nil)
        
        switch row {
        case 1:
            objMainViewController.showViewController(viewController: UINavigationController.self, mainViewController: self,storyboard: "Main", storyboardId: "HomeNavID")
        default:
            objMainViewController.showViewController(viewController: UINavigationController.self, mainViewController: self,storyboard: "Main", storyboardId: "SettingID")
        }
        
        
        // Collapse side menu with animation
        DispatchQueue.main.async { self.objMainViewController.sideMenuState(expanded: false) }
    }
}

extension SideMenuMainViewController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if objMainViewController.isExpanded {
                objMainViewController.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        objMainViewController.handlePanGesture(sender: sender)
    }
}

extension UIViewController {
    
    // With this extension you can access the MainViewController from the child view controllers.
    func revealViewController() -> SideMenuMainViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is SideMenuMainViewController {
            return viewController! as? SideMenuMainViewController
        }
        while (!(viewController is SideMenuMainViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is SideMenuMainViewController {
            return viewController as? SideMenuMainViewController
        }
        return nil
    }
}


