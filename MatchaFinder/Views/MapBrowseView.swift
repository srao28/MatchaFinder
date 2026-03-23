//
//  MapBrowseView.swift
//  MatchaFinder
//

import MapKit
import SwiftUI

struct MapBrowseView: View {
    @Environment(ShopDirectoryViewModel.self) private var directory
    @Environment(LocationManager.self) private var location

    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )
    @State private var selectedShop: MatchaShop?

    var body: some View {
        NavigationStack {
            Map(position: $position, selection: $selectedShop) {
                if location.authorizationStatus == .authorizedWhenInUse
                    || location.authorizationStatus == .authorizedAlways
                {
                    UserAnnotation()
                }
                ForEach(directory.allShops) { shop in
                    Annotation(shop.name, coordinate: shop.coordinate) {
                        Button {
                            selectedShop = shop
                        } label: {
                            Image(systemName: "leaf.fill")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(MatchaTheme.primary, in: Circle())
                        }
                        .buttonStyle(.plain)
                    }
                    .tag(shop)
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .navigationTitle("Map")
            .navigationDestination(item: $selectedShop) { shop in
                ShopDetailView(shop: shop)
            }
            .onAppear {
                location.startUpdatesIfAllowed()
            }
        }
    }
}

#Preview {
    MapBrowseView()
        .environment(ShopDirectoryViewModel())
        .environment(LocationManager())
}
