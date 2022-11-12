//
//  CustomAnnotation.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/12/22.
//

import Foundation
import MapKit
import UIKit

class CustomAnnotationView: MKAnnotationView {
    let identifier = "Custom"
    init(annotation: MKAnnotation?) {
        super.init(annotation: annotation, reuseIdentifier: identifier)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
