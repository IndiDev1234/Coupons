//
//  CouponHomeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

//
//  CouponHomeView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 04/08/26.
//

import SwiftUI

struct CouponHomeView: View {

    @State private var showAddCoupon = false
    @State private var searchText = ""

    var body: some View {

        ScrollView {

            VStack(spacing: 0) {

                // MARK: Header

                HStack {

                    Text("Coupons")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Button {

                        showAddCoupon = true

                    } label: {

                        Image(systemName: "plus")
                            .font(.title3.weight(.semibold))
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.glass)
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer(minLength: 60)

                // MARK: Empty State

                EmptyStateView {

                    showAddCoupon = true
                }

                Spacer(minLength: 80)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: UIScreen.main.bounds.height - 180)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden()
        .searchable(
            text: $searchText,
            placement: .automatic,
            prompt: "Search Coupons"
        )
        .sheet(isPresented: $showAddCoupon) {

            NavigationStack {

                AddCouponView()
            }
            .presentationDetents([
                .large
            ])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {

    NavigationStack {

        CouponHomeView()
    }
}
