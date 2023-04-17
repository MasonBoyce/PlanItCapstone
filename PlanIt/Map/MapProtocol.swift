//
//  MapProtocol.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit
import MapKit

protocol MapViewControllerProtocol: AnyObject {
    var mapView: MKMapView {get set}
    func updateAnnotations(annotations: [CustomAnnotation])
}

protocol MapModelProtocol: AnyObject {
    var annotations: [CustomAnnotation] { get set }
    var currentCoordinate: CLLocationCoordinate2D { get set }
//    var span: MKCoordinateSpan { get set }
//    var region: MKCoordinateRegion? { get set }
    func viewDidLoad()
}

protocol MapCoordinatorProtocol: AnyObject {
    
}
