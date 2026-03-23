//
//  ShopRowView.swift
//  MatchaFinder
//

import SwiftUI

struct ShopRowView: View {
    let shop: MatchaShop
    let distanceText: String

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(MatchaTheme.primary.opacity(0.25))
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "cup.and.saucer.fill")
                        .foregroundStyle(MatchaTheme.primary)
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(shop.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(distanceText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(MatchaTheme.primary)
                        .font(.caption)
                    Text(String(format: "%.1f", shop.rating))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        ShopRowView(shop: MockShopData.shops[0], distanceText: "1.2 km")
    }
}
