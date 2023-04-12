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
    var coordinator: MapCoordinatorProtocol?
    var sController: SelectionUIViewController?
    
    var currentCoordinate: CLLocationCoordinate2D
    var span: MKCoordinateSpan
    var region: MKCoordinateRegion
    var transportType: MKDirectionsTransportType?
    var venues: [Venue]
    var tripSession: TripSession?
    var optimal_route: [MKRoute]?
    var optimal_route_cost: Double?
    
    //Setting up custom annotations preinputed values
    var annotations: [CustomAnnotation] = []
    
    //MARK: FUNCTIONS
    
    init(venues: [Venue]) {
        
        currentCoordinate = LocationManager.shared.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        region = MKCoordinateRegion(center: currentCoordinate, span: span)
        self.venues = venues
        
        
       
        /*
        
        tripSession = TripSession(newVenues: venues)
        (self.optimal_route, self.optimal_route_cost) = tripSession?.find_optimal_venue_route_perm()!!
        
        for route in optimal_route {
            print(route.description)
        }
        
        addOverlays(optimal_route)
        
         */
        
    }
    
    func viewDidLoad() {
         
    }
    
    func addAnnotation(annotation: CustomAnnotation) {
        annotations.append(annotation)
    }
    
    func addAnnotations() {
        var index = 0
        for venue in venues {
            print("MASON BOYCE",venue)
            let venueLatitude: Double = venue.latitude ?? 0.0
            let venueLongitude: Double = venue.longitude ?? 0.0
            let venueName: String = venue.name ?? "Unknown"
            
            let annotation = CustomAnnotation(index: index, coordinate: CLLocationCoordinate2D(latitude: venueLatitude, longitude: venueLongitude), title: venueName, subtitle: nil)
            
            annotations.append(annotation)
            index += 1
        }
        viewController?.updateAnnotations(annotations: annotations)
    }
    
    func addOverlays(routes: [MKRoute]) {
            for route in routes {
                let polyline = route.polyline
                viewController?.mapView.addOverlay(polyline)
            }
        }
    
    
}
