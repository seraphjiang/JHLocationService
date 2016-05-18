//
//  JHLocationService.swift
//  Pods
//
//  Created by Huan Jiang on 5/17/16.
//
//

import UIKit
import CoreLocation

public class JHLocationService: NSObject, CLLocationManagerDelegate {
    public static let instance = JHLocationService()
    
    public let locationManager : CLLocationManager = CLLocationManager()
    
    public var currentLocation : CLLocation?
    
    public var delegate: CLLocationManagerDelegate?
    
    public override init() {
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 100
        self.locationManager.delegate = self
    }
    
    
    public func startUpdatingLocation() {
        print("Start updating location.")
        self.locationManager.requestAlwaysAuthorization()
        
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedAlways {
            self.locationManager.startUpdatingLocation()
        }
        else {
//            show("Location permission is not authorized!")
        }
        
        if self.delegate != nil {
            self.delegate?.locationManager!(manager, didChangeAuthorizationStatus: status)
        }
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location service failed with error ",  error.localizedDescription)
        
        if self.delegate != nil {
            self.delegate?.locationManager!(manager, didFailWithError: error)
        }
    }

    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        print("latitude:", location?.coordinate.latitude, ",","longitude", location?.coordinate.longitude)
        self.currentLocation = location
        
        if self.delegate != nil {
            self.delegate?.locationManager!(manager, didUpdateLocations: locations)
        }
    }
}
