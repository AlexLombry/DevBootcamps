//
//  LocationVC.swift
//  DevBootcamps
//
//  Created by Alex Lombry on 14/03/16.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    // permission available for user (user can denied it)
    let locationmanager = CLLocationManager()
    
    // Distance in meters
    let regionRadius: CLLocationDistance = 100000
    
    // debug addresses
    let addresses = [
        "22 Rue réaumur, 75002 Paris France",
        "23 Rue de cléry, 75002 Paris France",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // mandatory
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlaceFromAddress(add)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Initiate the Table View (mandatory func)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
    
    /// Authorisation by User ?
    func locationAuthStatus() {
        // have the user authorise app location when is currently use.
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // We can show the current user location
            map.showsUserLocation = true
        } else {
            // ask user if we can use location
            locationmanager.requestWhenInUseAuthorization()
        }
    }
    
    /// Create the centered region on map
    func centerLocationMap(_ location: CLLocation) {
        // create the coordinate
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    /// Update user location
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let locate = userLocation.location {
            centerLocationMap(locate)
        }
    }

    // annotation include also location
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        /// redundant nil return but only for learning purpose
        if annotation.isKind(of: BootcampAnnotation.self) {
            let anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            
            // change pin color and animation
            anView.pinTintColor = .green
            anView.animatesDrop = true
            
            return anView
        }
        
        return nil
    }
    
    func createAnnotationForLocation(_ location: CLLocation) {
        // create location and turn it into 
        // annotation and then put it on the map
        let locs = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(locs)
    }
    
    func getPlaceFromAddress(_ address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, nil) -> Void in
            if let marks = placemarks , marks.count > 0 {
                // if we have a valid location with lat lon
                if let loc = marks[0].location {
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
}

