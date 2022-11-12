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
    
}

protocol MapModelProtocol: AnyObject {
    var annotations: [MKPointAnnotation] { get set }
}

protocol MapCoordinatorProtocol: AnyObject {
    
}
