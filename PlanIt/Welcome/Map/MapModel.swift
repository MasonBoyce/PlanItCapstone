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
    var viewController: MapViewControllerProtocol?
    var coordinator: MapCoordinatorProtocol?
    
    var annotations: [MKPointAnnotation] = []
    let annotation: MKPointAnnotation = MKPointAnnotation()
    
    
    init() {
        defaultAnntotations()
    }
    
    func addAnnotation(annotation: MKPointAnnotation) {
        annotations.append(annotation)
    }
    
    func defaultAnntotations() {
        annotation.coordinate =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        annotation.title = "Monroe Hall"
        annotations.append(annotation)
    }
    
    
}
