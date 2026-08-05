//
//  CouponHomeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI

struct CouponHomeView: View {

    var body: some View {

        ScrollView {

            VStack(spacing: 154) {

                HStack(alignment: .center) {

                    Text("Coupons")
                        .font(.largeTitle.bold())

                    Spacer()

                    Button {

                    } label: {
                        Image(systemName: "plus")
                            .font(.title3.weight(.semibold))
                            .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.glass)
                }.padding()

                EmptyStateView()
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .searchable(
            text: .constant(""),
            placement: .automatic,
            prompt: "Search coupons"
        )
    }
}

#Preview {

    NavigationStack {
        CouponHomeView()
    }
}
