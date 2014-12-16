//
//  ViewController.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/16/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        let directionRequest = MKDirectionsRequest()
        let ladner = CLLocationCoordinate2D(latitude: 49.081241, longitude: -123.083793)
        let ladnerPlaceMark = MKPlacemark(coordinate: ladner, addressDictionary: nil)
        let ladnerMapItem = MKMapItem(placemark: ladnerPlaceMark)
        let van = CLLocationCoordinate2D(latitude: 49.266638, longitude: -123.249275)
        let vanPlaceMark = MKPlacemark(coordinate: van, addressDictionary: nil)
        let vanMapItem = MKMapItem(placemark: vanPlaceMark)
        
        directionRequest.setSource(ladnerMapItem)
        directionRequest.setDestination(vanMapItem)
        directionRequest.transportType = MKDirectionsTransportType.Automobile
        
        let point = MKPointAnnotation()
        point.coordinate = ladner
        mapView.addAnnotation(point)
        
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler({
            [unowned self](response: MKDirectionsResponse!, error: NSError!) in
            let route = response.routes[0] as MKRoute
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
        })
        
        let region = MKCoordinateRegionMakeWithDistance(ladner, 1000, 1000)
        mapView.region = region
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let polyRenderer = MKPolylineRenderer(overlay: overlay)
            polyRenderer.lineWidth = 3
            polyRenderer.strokeColor = UIColor.redColor().colorWithAlphaComponent(0.6)
            return polyRenderer
        }
        return nil
    }
}

