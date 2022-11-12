//
//  CustomAnnotationView.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/12/22.
//

import Foundation
import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.779_379, longitude: -122.418_433)
    var title: String?
    var subtitle: String?
    var index: Int?
    let identifier = "Annotation"
    init(index:Int,coordinate:CLLocationCoordinate2D,title:String?,subtitle:String?) {
        self.coordinate = coordinate
        self.index = index
        self.title = title
        self.subtitle = subtitle
//        super.init()
        }
}
