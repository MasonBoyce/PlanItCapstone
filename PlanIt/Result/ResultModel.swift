//
//  ResultModel.swift
//  PlanIt
//
//  Created by Michael on 4/19/23.
//

import Foundation
import UIKit
import MapKit

class ResultModel {
    var viewController: ResultViewController?
    var coordinator: ResultCoordinator?
    var tripSession: TripSession
    var transitType = Cache.shared.transitType
    
    init(tripSession: TripSession) {
        self.tripSession = tripSession
    }
    

    
}

