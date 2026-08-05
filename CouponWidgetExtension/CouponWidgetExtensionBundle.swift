//
//  CouponWidgetExtensionBundle.swift
//  CouponWidgetExtension
//
//  Created by Vansh Sharma on 04/08/26.
//

import WidgetKit
import SwiftUI

@main
struct CouponWidgetExtensionBundle: WidgetBundle {

    var body: some Widget {

        // Home Screen Widget (optional for now)
        CouponWidgetExtension()

        // Our Live Activity
        CouponLiveActivity()
    }
}
