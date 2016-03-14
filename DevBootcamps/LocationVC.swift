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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // mandatory
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func locationAuthStatus() {
        // have the user authorise app location when is currently use.
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            // We can show the current user location
            map.showsUserLocation = true
        } else {
            // ask user if we can use location
            locationmanager.requestWhenInUseAuthorization()
        }
    }
    
    /// MARK
    /// Initiate the Table View (mandatory func)
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
}

