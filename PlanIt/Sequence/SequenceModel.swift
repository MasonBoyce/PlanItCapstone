//
//  SequenceModel.swift
//  PlanIt
//
//  Created by Michael on 4/24/23.
//

import Foundation
import UIKit
import MapKit

class SequenceModel {
    var viewController: SequenceViewController?
    var coordinator: SequenceCoordinator?
    var transitType = Cache.shared.transitType
    
    
    func save() {
        Cache.shared.startID = viewController?.start ?? -1
        Cache.shared.endId = viewController?.end ?? -1
        
        
        Cache.shared.hasFixedEndPoints = true
        
    }
    
    
}
