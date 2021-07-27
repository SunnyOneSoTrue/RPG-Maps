//
//  MapViewController.swift
//  RPG Maps
//
//  Created by USER on 27.06.21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    
    
    //MARK: CREATING DIRECTIONS DOES NOT WORK. FIX IT!!
    @IBOutlet weak var mapView: MKMapView!
    
    let clLocationManager = CLLocationManager()
    var directionsArray: [MKDirections] = []
    
    var pins: [CustomPin] = []
    
    private var locationManager: LocationsManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        locationManager = LocationsManager()
        
        //MARK: Users location code
        clLocationManager.delegate = self
        clLocationManager.requestWhenInUseAuthorization()
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.distanceFilter = kCLDistanceFilterNone
        clLocationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        clLocationManager.delegate = self
        
        mapView.delegate = self
        
        //MARK: creates the zoom place for the launch of the map (change later to person's location)
        let regionRadius: CLLocationDistance = 750.0
        
        
        let region = MKCoordinateRegion(center: clLocationManager.location!.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        
        
        loadLocations()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    //MARK: This function takes the info from the provided API, creates a customPin class object, starts monitoring on the coordinates provided, adds the annotation directly to the mapView and appends it to the pins array.
    func loadLocations(){
        locationManager?.fetchData(completion: { Data in
            for i in 0..<Data.locations.count{
                //MARK: takes the coordinate and region of the specific landmark
                let coordiante = CLLocationCoordinate2D(latitude: Data.locations[i].coordinates.lat, longitude: Data.locations[i].coordinates.lng)
                let region = CLCircularRegion(center: coordiante, radius: 200, identifier: "dsnada")
                
                
                //this appends the custom pin into the pins array
                self.pins.append(CustomPin(title: Data.locations[i].name, subtitle: Data.locations[i].subtitle, type:Data.locations[i].type , latitude: Data.locations[i].coordinates.lat, longtitude: Data.locations[i].coordinates.lng))
                
                //MARK: adds the landmark directly to the map. because of this it takes a few seconds to load
                self.mapView.addAnnotation(CustomPin(title: Data.locations[i].name, subtitle: Data.locations[i].subtitle, type:Data.locations[i].type , latitude: Data.locations[i].coordinates.lat, longtitude: Data.locations[i].coordinates.lng))
                
                //MARK: starts monitoring for the specified region - if someone crosses into it it calls the DidEnterRegion function
                self.clLocationManager.startMonitoring(for: region)
            }
        })
    }
    
    //MARK: Changes the overlay of the map dependent on whats selected
    @IBAction func onChangeMap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybridFlyover
        default:
            return
        }
    }
    
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    
    //MARK: Adds Custom Images to specivic annotations (CHANGE LATER TO BE MORE OPTIMAL, NOT DEPENDENT ON NAMES)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation{
            return nil
        }

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        
        for pin in pins{
            if pin.title == annotation.title{
                switch pin.type {
                case types.Castle.rawValue:
                    annotationView.image = UIImage(named: "CastleIcon")
                case types.Church.rawValue:
                    annotationView.image = UIImage(named: "ChurchIcon")
                default:
                    annotationView.image = UIImage(named: "EyeIcon")
                }
            }
        }
        
        
        
        annotationView.canShowCallout = true
        return annotationView
    }
    
    //MARK:this is called when the user enters the monitored regions.
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //MARK: this shows the popup view controller on the screen
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PopUpViewController") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
        let vc = storyboard?.instantiateViewController(identifier: "AccountViewController") as! AccountViewController
        vc.loggedInUser.points += 500
        
        self.clLocationManager.stopMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.clLocationManager.stopMonitoring(for: region)
    }
    
    //MARK: This will show the routes to the selected location.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        getDirections(to: view.annotation!.coordinate)
        print(#function)
    }
    
    
    //MARK: this is needed for the directions. DO NOT DELETE
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 2.0
        
        return renderer
    }
    
    private  func getDirections(to destination: CLLocationCoordinate2D) {
        guard let location = clLocationManager.location?.coordinate else {
            //TODO: Inform user we don't have their current location
            return
        }
        
        let request = createDirectionsRequest(from: location, to: destination)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    private func resetMapView(withNew directions: MKDirections){
        mapView.removeOverlays(mapView.overlays)
        let _ = directionsArray.map {
            $0.cancel()
        }
        directionsArray.removeAll()
        directionsArray.append(directions)
    }
    
    private func createDirectionsRequest(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> MKDirections.Request {
        let startingLocation            = MKPlacemark(coordinate: coordinate1)
        let destination                 = MKPlacemark(coordinate: coordinate2)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
}
