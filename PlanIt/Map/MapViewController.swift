//
//  MapViewController.swift
//  PlanIt
//
//  Created by Mason Boyce on 11/11/22.
//

import Foundation
import UIKit
import MapKit
import CoreGraphics



class MapViewController: UIViewController, MapViewControllerProtocol {
    var welcomeLabel: UILabel?
    var model: MapModelProtocol?
    
    //MARK: View Elements
    
    //Sets intial Map with region and adds annotations from model
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.region = model?.region ?? MKCoordinateRegion(center: CLLocationCoordinate2D(), latitudinalMeters: 10.0, longitudinalMeters: 10.0)
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }()
    
    //MARK: Functions
    
    //sets up view
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
        model?.viewDidLoad()
        mapView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    func setUpView() {
        view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func updateAnnotations(annotations: [CustomAnnotation]) {
        var prevAnnotation: CustomAnnotation?
        model?.annotations.forEach {
            mapView.addAnnotation($0)
            if prevAnnotation != nil {
            }
            prevAnnotation = $0
        }
    }
    
}

//MARK: Extensions
//Takes in annotations when created and creates the view for it
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //make sure it is of the component CustomAnnotation
    guard let annotation = annotation as? CustomAnnotation else {
        return nil
    }
    //creates the annotaitonView if it doesnt exist
    let identifier = "Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
    if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
    } else {
        annotationView?.annotation = annotation
    }
    
    //Set a custom image for the annotationView
    let size = CGSize(width: 30, height: 30)
    switch annotation.index {
    case 0:
        var image1 = UIImage(named: "number1")
        image1 = image1?.resizeUI(size: size)
        annotationView?.image = image1
        
    case 1:
        var image2 = UIImage(named: "number2")
        image2 = image2?.resizeUI(size: size)
        annotationView?.image = image2
    default:
        var image3 = UIImage(named: "number3")
        image3 = image3?.resizeUI(size: size)
        annotationView?.image = image3
    }
    
    return annotationView
}


//MARK: Extensions

//Draws the line for the directions
extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .systemRed
        
        return renderer
    }
}
