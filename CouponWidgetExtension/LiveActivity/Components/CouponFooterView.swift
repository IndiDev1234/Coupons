//
//  CouponFooterView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 05/08/26.
//


import SwiftUI

struct CouponFooterView: View {

    let distance: String
    let expiryDate: Date

    var body: some View {

        HStack {
            
            Label {
                
                Text(distance)
                
            } icon: {
                
                Image(systemName: ActivityIcons.location)
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            
            CountdownView(
                expiryDate: expiryDate
            )
        }        
        .font(ActivityFonts.caption)
        .foregroundStyle(ActivityColors.secondaryText)
    }
}
