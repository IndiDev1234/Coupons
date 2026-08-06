//
//  CouponScannerView.swift
//  CouponFeature
//

import SwiftUI
import PhotosUI
import UIKit

struct CouponScannerView: View {

    @State
    private var viewModel = CouponScannerViewModel()

    @State
    private var selectedPhoto: PhotosPickerItem?

    @State
    private var selectedImage: UIImage?

    @State
    private var showCamera = false

    var body: some View {

        ScrollView {

            VStack(spacing: 32) {

                heroSection

                featuresSection

                actionsSection

                supportedFormatsSection
            }
            .padding(24)
        }
        .navigationTitle("Scan Coupon")
        .navigationBarTitleDisplayMode(.inline)

        .overlay {

            if viewModel.isScanning {

                scanningOverlay
            }
        }

        .alert(
            "Scanner Error",
            isPresented: Binding(
                get: {
                    viewModel.errorMessage != nil
                },
                set: { value in

                    if !value {

                        viewModel.errorMessage = nil
                    }
                }
            )
        ) {

            Button("OK", role: .cancel) {

                viewModel.errorMessage = nil
            }

        } message: {

            Text(viewModel.errorMessage ?? "")
        }

        .onChange(of: selectedPhoto) { _, newValue in

            guard let newValue else { return }

            Task {

                do {

                    guard
                        let data = try await newValue.loadTransferable(type: Data.self),
                        let image = UIImage(data: data)
                    else {

                        viewModel.errorMessage = "Unable to load image."

                        return
                    }

                    await viewModel.scan(image: image)

                } catch {

                    viewModel.errorMessage = error.localizedDescription
                }
            }
        }

        .navigationDestination(
            isPresented: $viewModel.showReview
        ) {

            if let draft = viewModel.draft {

                CouponReviewView(
                    draft: draft
                )
            }
        }

        .fullScreenCover(isPresented: $showCamera) {

            CameraScannerView(

                onImageCaptured: { image in

                    showCamera = false

                    Task {

                        // Give SwiftUI a moment to dismiss the cover.
                        try? await Task.sleep(for: .milliseconds(300))

                        await viewModel.scan(image: image)
                    }
                },

                onCancel: {

                    showCamera = false
                }
            )
        }
    }
}

// MARK: Hero

private extension CouponScannerView {

    var heroSection: some View {

        VStack(spacing: 18) {

            Image(systemName: "document.viewfinder")
                .font(.system(size: 72))
                .foregroundStyle(.blue)

            Text("Scan Coupon")
                .font(.largeTitle.bold())

            Text(
                "Automatically detect the merchant, coupon code, discount and expiry date from your coupon."
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
        }
    }
}

// MARK: Features

private extension CouponScannerView {

    var featuresSection: some View {

        VStack(alignment: .leading, spacing: 16) {

            feature("Merchant Detection", systemImage: "building.2")

            feature("Coupon Code Recognition", systemImage: "number")

            feature("Discount Detection", systemImage: "tag")

            feature("Expiry Detection", systemImage: "calendar")
        }
    }
}

// MARK: Actions

private extension CouponScannerView {

    var actionsSection: some View {

        VStack(spacing: 16) {

            ScannerActionCard(
                icon: "viewfinder.circle.fill",
                iconColor: .blue,
                title: "Scan with Camera",
                subtitle: "Capture a printed coupon."
            ) {

                showCamera = true
            }

            PhotosPicker(
                selection: $selectedPhoto,
                matching: .images
            ) {

                ScannerActionCard(
                    icon: "photo.on.rectangle.angled",
                    iconColor: .green,
                    title: "Choose from Photos",
                    subtitle: "Import screenshots or saved coupons."
                ) {

                }
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: Footer

private extension CouponScannerView {

    var supportedFormatsSection: some View {

        VStack(spacing: 10) {

            Label(
                "Supports screenshots, flyers and coupon images",
                systemImage: "checkmark.seal.fill"
            )

            Text("PDF support coming soon")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .font(.footnote)
        .padding(.top)
    }
}

// MARK: Loading

private extension CouponScannerView {

    var scanningOverlay: some View {

        ZStack {

            Color.black.opacity(0.15)
                .ignoresSafeArea()

            VStack(spacing: 16) {

                ProgressView()

                Text("Scanning Coupon...")
                    .font(.headline)
            }
            .padding(28)
            .background(.regularMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24
                )
            )
        }
    }
}

// MARK: Helpers

private extension CouponScannerView {

    func feature(
        _ title: String,
        systemImage: String
    ) -> some View {

        Label(title, systemImage: systemImage)
            .font(.headline)
    }
}
