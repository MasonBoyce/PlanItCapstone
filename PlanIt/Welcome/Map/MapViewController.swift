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
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        let currentCoordinator =  CLLocationCoordinate2D(latitude: 29.9407, longitude: -90.1203)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: currentCoordinator, span: span)
        
        map.region = region
        map.translatesAutoresizingMaskIntoConstraints = false
        map.dequeueReusableAnnotationView(withIdentifier: "annotation")
        
        var prevAnnotation: CustomAnnotation?
        model?.annotations.forEach {
            map.addAnnotation($0)
            if prevAnnotation != nil {
                createDirections(sourceLocation: prevAnnotation!.coordinate, destinationLocation: $0.coordinate)
            }
            prevAnnotation = $0
        }
        return map
    }()
    
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
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
    
    func createDirections(sourceLocation: CLLocationCoordinate2D,destinationLocation: CLLocationCoordinate2D) {
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .walking
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("ERROR FOUND : \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            
            //                let rect = route.polyline.boundingMapRect
            //
            //                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
       
}
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else {
            return nil
        }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
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
    
    
}
    
extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("hello in here")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .systemRed
        
        return renderer
    }
}
//Put this in an UIImage extension file
extension UIImage {
    func resizeUI(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
