//
//  ViewController.swift
//  MapKitViewDemo
//
//  Created by Mac on 11/01/24.
//

import UIKit
import MapKit
class ViewController: UIViewController {
   
    
    @IBOutlet weak var MapKitView: MKMapView!
    var mKMutablePathForPolygon : MKPolygon?
    var mKMutablePathForPolyline : MKPolyline?
    var cameraPosition : MKMapCamera?
    var bitCodePin : MKPlacemark?
    var pointAnnotation : MKPointAnnotation?
    var regionCoordinate :  MKCoordinateRegion?
    var shaniwarWadaCoorfinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 18.5195, longitude: 73.8553)
    override func viewDidLoad() {
        super.viewDidLoad()
        MapKitView.delegate = self
        //setPinUsingMkPlaceMark()
        setPointsUsingAnnotation()
        drawCircleOnMKMapView(center: shaniwarWadaCoorfinates, radius: 500.0)
        drawPolygonOnMkMapView()
        drawPolylineOnMKMapView()
        zoomSetting(position: shaniwarWadaCoorfinates, zoomLevel: 20.0)
    }
    func setPinUsingMkPlaceMark(){
        let bitCodeCordinate = CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326)
        bitCodePin = MKPlacemark(coordinate: bitCodeCordinate)
        let region = MKCoordinateRegion(center: bitCodeCordinate, latitudinalMeters: 800.0, longitudinalMeters: 800.0)
        MapKitView.setRegion(region, animated: true)
        MapKitView.addAnnotation(bitCodePin!)
    }
    func setPointsUsingAnnotation(){
        pointAnnotation  = MKPointAnnotation()
        pointAnnotation?.coordinate = CLLocationCoordinate2D(latitude: 18.5195, longitude: 73.8553)
        pointAnnotation!.title = "ShanivarWada"
        let shanivarWadaRegion = MKCoordinateRegion(center: pointAnnotation!.coordinate, latitudinalMeters: 800.0, longitudinalMeters: 800.0)
        MapKitView.setRegion(shanivarWadaRegion, animated: true)
        MapKitView.addAnnotation(pointAnnotation!)
    }
    func drawCircleOnMKMapView(center : CLLocationCoordinate2D, radius : CLLocationDistance){
        let mkCircle = MKCircle(center: shaniwarWadaCoorfinates, radius: radius)
        mkCircle.title = "Shanivar Wada"
        MapKitView.addOverlay(mkCircle)

        
    }
    func zoomSetting(position: CLLocationCoordinate2D, zoomLevel: Double) {
        let camera = MKMapCamera()
        camera.centerCoordinate = position
        camera.altitude = pow(2, zoomLevel) // Adjust this value for desired zoom level
        MapKitView.setCamera(camera, animated: true)
    }

    func drawPolylineOnMKMapView(){
        let polylineCoordinates = [CLLocationCoordinate2D(latitude: 19.9975, longitude: 78.1307),
        CLLocationCoordinate2D(latitude: 21.1458, longitude: 79.0882),
        CLLocationCoordinate2D(latitude: 19.9615, longitude: 79.2916),
        CLLocationCoordinate2D(latitude: 19.6766, longitude: 78.1307),
        CLLocationCoordinate2D(latitude: 19.9975, longitude: 78.1307)]
        let polyline = MKPolyline(coordinates: polylineCoordinates, count: 5)
        MapKitView.addOverlay(polyline)
    }
    func drawPolygonOnMkMapView(){
            let polygonCoordinates =
            [CLLocationCoordinate2D(latitude: 19.9975, longitude: 73.7898),
            CLLocationCoordinate2D(latitude: 19.8762, longitude: 75.3433),
            CLLocationCoordinate2D(latitude: 17.6599, longitude: 75.9064),
            CLLocationCoordinate2D(latitude: 18.5202, longitude: 73.8567)]
            
        let polygone = MKPolygon(coordinates: polygonCoordinates, count: polygonCoordinates.count)
        MapKitView.addOverlay(polygone)
        }
}

extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = .cyan.withAlphaComponent(0.25)
            circleRenderer.strokeColor = .clear
            circleRenderer.lineWidth = 1
            return circleRenderer
        } else if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            polylineRenderer.strokeColor = .red
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        } else if let polygon = overlay as? MKPolygon {
            let polygonRenderer = MKPolygonRenderer(overlay: polygon)
            polygonRenderer.fillColor = .blue.withAlphaComponent(0.5)
            polygonRenderer.strokeColor = .blue
            polygonRenderer.lineWidth = 2
            return polygonRenderer
        }
        return MKOverlayRenderer()
    }
}
