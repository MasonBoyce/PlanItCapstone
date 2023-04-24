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
    var model: MapModel?
    //MARK: View Elements
    
    //Sets intial Map with region and adds annotations from model
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Results in ListView", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToResult), for: .touchUpInside)
        return button
    }()
    
    @objc private func goToResult() {
            model?.goToResult()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
    }
    
    //MARK: Functions
    
    //sets up view
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
        model?.viewDidLoad()
        mapView.delegate = self
        submitButton.layer.shadowColor = UIColor.systemGray.cgColor
        submitButton.layer.shadowRadius = 8
        submitButton.layer.shadowOpacity = 1
        submitButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
    let configuration = UIImage.SymbolConfiguration(pointSize: 37.5)
    
    switch annotation.index {
    
    case 0:
        let image = UIImage(systemName: "1.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 1:
        let image = UIImage(systemName: "2.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 2:
        let image = UIImage(systemName: "3.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 3:
        let image = UIImage(systemName: "4.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 4:
        let image = UIImage(systemName: "5.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 5:
        let image = UIImage(systemName: "6.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    case 6:
        let image = UIImage(systemName: "7.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    default:
        let image = UIImage(systemName: "8.circle.fill", withConfiguration: configuration)
        annotationView?.image = image
    }
    return annotationView
}

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
