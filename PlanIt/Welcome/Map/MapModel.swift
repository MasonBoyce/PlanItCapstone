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
    let annotation1: MKPointAnnotation = MKPointAnnotation()
    let annotation2: MKPointAnnotation = MKPointAnnotation()
    let annotation3: MKPointAnnotation = MKPointAnnotation()
    
    
    init() {
        defaultAnntotations()
    }
    
    func addAnnotation(annotation: MKPointAnnotation) {
        annotations.append(annotation)
    }
    
    func defaultAnntotations() {
        annotation1.coordinate =  CLLocationCoordinate2D(latitude: 29.93885, longitude: -90.11857)
        annotation1.title = "Monroe Hall"
        
        annotation2.coordinate =  CLLocationCoordinate2D(latitude: 29.94159, longitude: -90.11996)
        annotation2.title = "Warren Hall"
        
        annotation3.coordinate =  CLLocationCoordinate2D(latitude: 29.94467, longitude: -90.1166)
        annotation3.title = "Yulman Stadium"
        
        annotations.append(annotation1)
        annotations.append(annotation2)
        annotations.append(annotation3)
    }
    
    
}
