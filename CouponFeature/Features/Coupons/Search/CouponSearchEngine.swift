import Foundation

struct CouponSearchEngine {

    func search(
        coupons: [Coupon],
        text: String,
        filter: CouponFilter,
        sort: CouponSortOption
    ) -> [Coupon] {

        var results = coupons

        // MARK: Search

        if !text.isEmpty {

            let query = text.lowercased()

            results = results.filter {

                $0.title.lowercased().contains(query)

                ||

                ($0.merchant?.name.lowercased().contains(query) ?? false)

                ||

                ($0.couponCode?.lowercased().contains(query) ?? false)
            }
        }

        // MARK: Filter

        switch filter {

        case .all:
            break

        case .active:

            results = results.filter {

                !$0.isRedeemed &&
                ($0.expiryDate ?? .distantFuture) > .now
            }

        case .favorites:

            results = results.filter {

                $0.isFavorite
            }

        case .expiring:

            results = results.filter {

                guard let expiry = $0.expiryDate else {

                    return false
                }

                let days = Calendar.current.dateComponents(
                    [.day],
                    from: .now,
                    to: expiry
                ).day ?? 999

                return days <= 7 && days >= 0
            }

        case .redeemed:

            results = results.filter {

                $0.isRedeemed
            }

        case .nearby:

            // We'll connect this later.
            break
        }

        // MARK: Sort

        switch sort {

        case .newest:

            results.sort {
                $0.createdAt > $1.createdAt
            }

        case .oldest:

            results.sort {
                $0.createdAt < $1.createdAt
            }

        case .expiry:

            results.sort {
                ($0.expiryDate ?? .distantFuture) <
                ($1.expiryDate ?? .distantFuture)
            }

        case .merchant:

            results.sort {
                ($0.merchant?.name ?? "") <
                ($1.merchant?.name ?? "")
            }

        case .highestDiscount:

            results.sort {
                ($0.discountValue ?? 0) >
                ($1.discountValue ?? 0)
            }
        }

        return results
    }
}
