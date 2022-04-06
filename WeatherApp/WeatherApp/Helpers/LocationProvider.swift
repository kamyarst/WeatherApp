//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Combine
import CoreLocation

final class LocationProvider {

    @Published var location: Result<CLLocation, Error>?
    private var locationManager = CLLocationManager()
    private var bag = Set<AnyCancellable>()

    init() {
        self.bindLocation()
        self.bindAuthorizationStatus()
    }

    private func bindAuthorizationStatus() {
        self.locationManager.publisher(for: \.authorizationStatus).sink { status in
            switch status {
            case .notDetermined, .restricted, .denied:
                let error = NSError(domain: "Fail to get your location", code: 1)
                self.location = .failure(error)

            case .authorizedAlways, .authorizedWhenInUse:
                self.requestForLocation()

            @unknown default:
                break
            }
        }.store(in: &self.bag)
    }

    private func bindLocation() {

        self.locationManager.publisher(for: \.location)
            .sink { [weak self] location in
                guard let self = self,
                      let location = location
                else { return }

                self.location = .success(location)
            }.store(in: &self.bag)
    }

    func requestForLocation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
}
