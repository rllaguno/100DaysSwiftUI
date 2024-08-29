//
//  ContentView.swift
//  BucketList
//
//  Created by Rodrigo Llaguno on 24/08/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                ZStack {
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.standardStyle ? .standard : .hybrid)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Button(viewModel.standardStyle ? "Standard" : "Hybrid") {
                                viewModel.standardStyle.toggle()
                            }
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        .foregroundStyle(.white)
                        Spacer()
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(viewModel.errorMessage, isPresented: $viewModel.authenticationError) {
                    Button("OK") { }
                }
        }
    }
}

#Preview {
    ContentView()
}
