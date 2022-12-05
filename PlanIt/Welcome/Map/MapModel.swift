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
    
    var currentCoordinate: CLLocationCoordinate2D
    var span: MKCoordinateSpan
    var region: MKCoordinateRegion
    var transportType: MKDirectionsTransportType = .walking
    var venues: [Venue] = []
    
    //Setting up custom annotations preinputed values
    var annotations: [CustomAnnotation] = []
    var annotation1 = CustomAnnotation(index: 0, coordinate: CLLocationCoordinate2D(latitude: 29.93885, longitude: -90.11857), title: "Monroe Hall", subtitle: "former home")
    var annotation2 = CustomAnnotation(index: 1, coordinate: CLLocationCoordinate2D(latitude: 29.94159, longitude: -90.11996), title: "Warren Hall", subtitle: nil)
    var annotation3 = CustomAnnotation(index: 2, coordinate:  CLLocationCoordinate2D(latitude: 29.94467, longitude: -90.1166), title: "Yulman Stadium", subtitle: "hosts the best team in the country")
    
    //MARK: FUNCTIONS
    
    init() {
        currentCoordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        region = MKCoordinateRegion(center: currentCoordinate, span: span)
        defaultAnntotations()
        getYelpData()
        
    }
    
    func addAnnotation(annotation: CustomAnnotation) {
        annotations.append(annotation)
    }
    
    func defaultAnntotations() {
        annotations.append(annotation1)
        annotations.append(annotation2)
        annotations.append(annotation3)
    }
    
    
    func getYelpData(){
        let latitude = currentCoordinate.latitude
        let longitude = currentCoordinate.longitude
        let category = "gyms"
        let limit = 5
        let sortBy = "distance"
        let locale = "en_US"
        
        let yelpApi = YelpApi()
        yelpApi.retriveVenues(latitude: latitude, longitude: longitude, category: category, limit: limit, sortBy: sortBy, locale: locale) {
            (response, error) in
            if let response = response {
                print("here sucker \(response)")
                self.venues = response
                
                //HANDLE ERROR
            }
        }
        
        
    }
    
    
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
