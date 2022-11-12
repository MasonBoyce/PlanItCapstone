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
    
    var annotations: [CustomAnnotation] = []
    var annotation1 = CustomAnnotation(index: 0, coordinate: CLLocationCoordinate2D(latitude: 29.93885, longitude: -90.11857), title: "Monroe Hall", subtitle: "former home")
    
    var annotation2 = CustomAnnotation(index: 1, coordinate: CLLocationCoordinate2D(latitude: 29.94159, longitude: -90.11996), title: "Warren Hall", subtitle: nil)
    
    var annotation3 = CustomAnnotation(index: 2, coordinate:  CLLocationCoordinate2D(latitude: 29.94467, longitude: -90.1166), title: "Yulman Stadium", subtitle: "hosts the best team in the country")
    
    
    
    init() {
        defaultAnntotations()
    }
    
    func addAnnotation(annotation: CustomAnnotation) {
        annotations.append(annotation)
    }
    
    func defaultAnntotations() {
        
        
        annotations.append(annotation1)
        annotations.append(annotation2)
        annotations.append(annotation3)
    }
    
    
}
