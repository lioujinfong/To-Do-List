//
//  M_LocationManager.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/23.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject{
    private let locationManager = CLLocationManager()

    //Alert...
    @Published var permissionDenied = false
    
    //Region
    @Published var region : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var latitude : String = ""
    @Published var longitude : String = ""
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //checking premisssions...
        switch manager.authorizationStatus {
        case .denied:
            //Alert...
            permissionDenied.toggle()
            print("denied")
        case .notDetermined:
            //Requesting...
            manager.requestWhenInUseAuthorization()
            print("notDetermined")
        case .authorizedWhenInUse:
            //If Permission Given...
            manager.startUpdatingLocation()
            manager.requestLocation()
            print("authorizedWhenInUse")
            permissionDenied.toggle()
        case .authorizedAlways:
            
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Error...
        //print(error.localizedDescription)
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude1 = location.coordinate.latitude
            let longitude1 = location.coordinate.longitude
            
            region = CLLocationCoordinate2D(latitude: latitude1, longitude: longitude1)
            latitude = String(region.latitude)
            longitude = String(region.longitude)
            
        }
    

        
    }
}
