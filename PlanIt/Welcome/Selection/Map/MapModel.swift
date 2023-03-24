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
    var transportType: MKDirectionsTransportType = .walking
    var venues: [Venue]
    var tripSession: TripSession?
    
    //Setting up custom annotations preinputed values
    var annotations: [CustomAnnotation] = []
    
    //MARK: FUNCTIONS
    
    init(venues: [Venue]) {
        currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        region = MKCoordinateRegion(center: currentCoordinate, span: span)
        self.venues = venues
        tripSession = TripSession(newVenues: venues)
    }
    
    func viewDidLoad() {
         
    }
    
//    func converttostring(){
//        var array = venues
//        let result = venues[Venue].joined(separator: "-")
//    }
    
    func addAnnotation(annotation: CustomAnnotation) {
        annotations.append(annotation)
    }
    
    func addAnnotations() {
        var index = 0
        for venue in venues {
            let venueLatitude: Double = venue.latitude ?? 0.0
            let venueLongitude: Double = venue.longitude ?? 0.0
            let venueName: String = venue.name ?? "Unknown"
            
            let annotation = CustomAnnotation(index: index, coordinate: CLLocationCoordinate2D(latitude: venueLatitude, longitude: venueLongitude), title: venueName, subtitle: nil)
            
            annotations.append(annotation)
            index += 1
        }
        viewController?.updateAnnotations(annotations: annotations)
        
    }
    

    
//    func getYelpData(){
//        let latitude = currentCoordinate.latitude
//        let longitude = currentCoordinate.longitude
//        let category = result
//        let limit = 5
//        let sortBy = "distance"
//        let locale = "en_US"
//
//        let yelpApi = YelpApi()
//        yelpApi.retriveVenues(latitude: latitude, longitude: longitude, category: category!, limit: limit, sortBy: sortBy, locale: locale) {
//            (response, error) in
//            if let response = response {
//                self.venues = response
//                DispatchQueue.main.async {
//                    self.addAnnotations()
//
//                }
//                //HANDLE ERROR
//            }
//        }
//
//
//    }
    
    
    //Create a directions request send the source and destination
    //Then calculate the route and tthe add an overlay
    func createOverlay(sourceLocation: CLLocationCoordinate2D,destinationLocation: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = transportType
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.viewController?.mapView.addOverlay(route.polyline)
            
            //        let rect = route.polyline.boundingMapRect
            //
            //        self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }
}
