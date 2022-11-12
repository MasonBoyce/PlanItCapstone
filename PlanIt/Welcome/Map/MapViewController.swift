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
    
    lazy var map: MKMapView = {
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
   
    func setUpView() {
        view.addSubview(map)

        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }

}
