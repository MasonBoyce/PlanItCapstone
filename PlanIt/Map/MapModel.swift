//
//  MapModel.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit
import MapKit

class MapModel: MapModelProtocol {
    //MARK: Model Variables
    var viewController: MapViewControllerProtocol?
    var coordinator: MapCoordinator?
    var sController: SelectionUIViewController?
    var currentCoordinate: CLLocationCoordinate2D
    var region: MKCoordinateRegion?
    var transportType: MKDirectionsTransportType?
    var venues: [Venue]
    var tripSession: TripSession?
    var optimal_route: [MKRoute]?
    var optimal_route_cost: Double?
    
    
    
    //Setting up custom annotations preinputed values
    var annotations: [CustomAnnotation] = []
    
    //MARK: FUNCTIONS
    
    init(venues: [Venue]) {
        currentCoordinate = LocationManager.shared.destinationLoaction ?? LocationManager.shared.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        
        self.venues = venues
    }
    
    func viewDidLoad() {
        optimal_route = tripSession?.ordered_routes
        addAnnotations()
        addOverlays(routes: optimal_route!)
        
    }
    
    func goToResult() {
        coordinator?.goToResult()
    }
    
    func addAnnotation(annotation: CustomAnnotation) {
        annotations.append(annotation)
    }
    
    func addAnnotations() {
        let venuesFromTripSession: [Venue]
        
        if  tripSession?.optimal_venue_order == [] {
            venuesFromTripSession = venues
        } else {
            venuesFromTripSession = tripSession?.optimal_venue_order ?? venues
        }
    
        var index = 0
        var minLatitude = 10000.0
        var maxLatitude = -1000000.0
        var minLongitude = 100000.0
        var maxLongitude = -100000.0
        
        for venue in venuesFromTripSession {
            let venueLatitude: Double = venue.latitude ?? 0.0
            let venueLongitude: Double = venue.longitude ?? 0.0
            let venueName: String = venue.name ?? "Unknown"
            let annotation = CustomAnnotation(index: index, coordinate: CLLocationCoordinate2D(latitude: venueLatitude, longitude: venueLongitude), title: venueName, subtitle: nil)
            
            annotations.append(annotation)
            index += 1

            minLatitude = min(minLatitude, venueLatitude)
            maxLatitude = max(maxLatitude, venueLatitude)
            minLongitude = min(minLongitude, venueLongitude)
            maxLongitude = max(maxLongitude, venueLongitude)
            
        }
            
        let buffer = 0.006
        viewController?.updateAnnotations(annotations: annotations)
        let centerLatitude = (minLatitude + maxLatitude) / 2
        let centerLongitude = (minLongitude + maxLongitude) / 2
        let centerCoordinate = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let span = MKCoordinateSpan(latitudeDelta: maxLatitude - minLatitude + buffer, longitudeDelta: maxLongitude - minLongitude + buffer)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        viewController?.mapView.setRegion(region, animated: true)
    }
    
    func addOverlays(routes: [MKRoute]) {
        for route in routes {
            let polyline = route.polyline
            viewController?.mapView.addOverlay(polyline)
        }
    }
    
    
    
    
}
