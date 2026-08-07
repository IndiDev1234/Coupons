//
//  NearbyCouponsMapView.swift
//  CouponFeature
//

import SwiftUI
import SwiftData
import MapKit

struct NearbyCouponsMapView: View {

    // MARK: Environment

    @Environment(\.modelContext)
    private var modelContext

    // MARK: State

    @State
    private var cameraPosition: MapCameraPosition = .automatic

    @State
    private var selectedCoupon: CouponAnnotation?

    @State
    private var locationService = LocationService()

    @State
    private var viewModel: NearbyCouponsMapViewModel

    // MARK: Initializer

    init() {

        let locationService = LocationService()

        let merchantService = MerchantLocationService(
            locationService: locationService
        )

        let engine = NearbyCouponEngine(
            merchantLocationService: merchantService
        )

        _viewModel = State(
            initialValue: NearbyCouponsMapViewModel(
                engine: engine
            )
        )

        _locationService = State(
            initialValue: locationService
        )
    }

    // MARK: Body

    var body: some View {

        Map(
            position: $cameraPosition,
            selection: $selectedCoupon
        ) {

            UserAnnotation()

            ForEach(viewModel.annotations) { annotation in

                Annotation(
                    annotation.merchantName,
                    coordinate: annotation.coordinate
                ) {

                    CouponMapAnnotationView(
                        annotation: annotation
                    )
                }
                .tag(annotation)
            }
        }
        .mapControls {

            MapCompass()

            MapUserLocationButton()

            MapPitchToggle()

            MapScaleView()
        }
        .navigationTitle("Nearby Coupons")
        .navigationBarTitleDisplayMode(.inline)

        .task {

            await viewModel.loadCoupons(
                using: modelContext
            )

            moveToUserLocation()
        }

        .sheet(item: $selectedCoupon) {

            annotation in

            VStack(spacing: 20) {

                Text(annotation.coupon.title)
                    .font(.title2.bold())

                Text(annotation.merchantName)
                    .foregroundStyle(.secondary)

                Text(
                    "\(Int(annotation.distance)) m away"
                )
                .foregroundStyle(.green)

                Divider()

                Text(
                    annotation.coupon.couponCode ?? "No Coupon Code"
                )
                .font(.title3.monospaced())

                Button("Navigate") {

                    annotation.merchantLocation.mapItem
                        .openInMaps()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .presentationDetents([
                .medium
            ])
        }
    }
}

// MARK: Private

private extension NearbyCouponsMapView {

    func moveToUserLocation() {

        guard let location = locationService.currentLocation else {

            return
        }

        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
        )
    }
}

#Preview {

    NavigationStack {

        NearbyCouponsMapView()
            .modelContainer(
                PersistenceController.shared.modelContainer
            )
    }
}
