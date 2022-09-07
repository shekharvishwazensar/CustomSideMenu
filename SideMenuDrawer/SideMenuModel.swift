//
//  SideMenuModel.swift
//  SideMenuDrawer
//
//  Created by SV59349 on 02/09/22.
//

import UIKit


public struct SideMenuModel {
    var icon: UIImage?
    var title: String
    
    public init(icon: UIImage? = nil, title: String) {
        self.icon = icon
        self.title = title
    }
}
