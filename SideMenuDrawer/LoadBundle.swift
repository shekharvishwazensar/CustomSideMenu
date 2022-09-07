//
//  LoadBundle.swift
//  SideMenuDrawer
//
//  Created by SV59349 on 05/09/22.
//

import UIKit

public class LoadBundle {
    public static func bundle(view: AnyClass) -> Bundle {
        let bundle = Bundle(for: view)
        guard let cocoapodsBundle = bundle
                .path(forResource: "SideMenuDrawer", ofType: "bundle")
                .flatMap(Bundle.init(path:)) else {
                    return bundle
                }
        return cocoapodsBundle
    }
}
