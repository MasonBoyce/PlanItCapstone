//
//  MapViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MapViewControllerProtocol {
    var welcomeLabel: UILabel?
    
    var model: MapModelProtocol?
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        let currentCoordinator =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: currentCoordinator, span: span)
        map.region = region
        map.translatesAutoresizingMaskIntoConstraints = false
        model?.annotations.forEach {
            
            map.addAnnotation($0)
        }
        return map
    }()
    
    
    
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
        mapView.delegate = self
        let coordinate1:CLLocationCoordinate2D = model?.annotations[0].coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let coordinate2:CLLocationCoordinate2D = model?.annotations[1].coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        createDirections(sourceLocation: coordinate1, destinationLocation: coordinate2)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
   
    func setUpView() {
        view.addSubview(mapView)

        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createDirections(sourceLocation: CLLocationCoordinate2D,destinationLocation: CLLocationCoordinate2D) {
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
            let destinationItem = MKMapItem(placemark: destinationPlaceMark)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationItem
            directionRequest.transportType = .walking
            
            let direction = MKDirections(request: directionRequest)
            
            direction.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print("ERROR FOUND : \(error.localizedDescription)")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline)
                
//                let rect = route.polyline.boundingMapRect
//
//                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
          }
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    

}
}
extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("hello in here")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .systemRed
        
        return renderer
    }
}
