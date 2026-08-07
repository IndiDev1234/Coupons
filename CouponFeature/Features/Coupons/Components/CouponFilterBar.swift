//
//  CouponFilterBar.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 07/08/26.
//


import SwiftUI

struct CouponFilterBar: View {

    @Binding
    var selectedFilter: CouponFilter

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 10) {

                ForEach(CouponFilter.allCases) { filter in

                    Button {

                        withAnimation(.snappy) {

                            selectedFilter = filter
                        }

                    } label: {

                        HStack(spacing: 6) {

                            Image(systemName: filter.icon)

                            Text(filter.title)
                        }
                        .font(.subheadline.weight(.medium))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .foregroundStyle(
                            selectedFilter == filter
                            ? .white
                            : filter.tint
                        )
                        .background {

                            Capsule()
                                .fill(
                                    selectedFilter == filter
                                    ? filter.tint
                                    : filter.tint.opacity(0.15)
                                )
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}