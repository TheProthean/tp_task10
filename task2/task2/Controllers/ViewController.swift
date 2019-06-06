//
//  ViewController.swift
//  task2
//
//  Created by Anton on 5/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 53.916667 , longitude: 27.55)
    let regionRadius: CLLocationDistance = 20000

    var districts: [String: CLLocationCoordinate2D] = [:]
    
    func centerMapOnLocation(location: CLLocation) {
        locationManager.delegate = self
        mapView.delegate = self
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        for district in districts {
            print(district)
            mapView.addAnnotation(MuseumDetails(title: district.key, coordinate: district.value))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readDataFromDB()
        centerMapOnLocation(location: initialLocation)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let vc = segue.destination as? DetailsViewController {
                let artwork = sender as! MuseumDetails
                var district = DistrictDetails()
                district.name = artwork.title
                district.museums = {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let managedObjectContext = appDelegate.persistentContainer.viewContext
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Museum")
                    var museums: [String] = []
                    do{
                        
                        let results = try managedObjectContext.fetch(fetchRequest)
                        
                        if results.count == 0 {
                            print("Nothing was found")
                            
                            let entity = NSEntityDescription.entity(forEntityName: "Museum", in: managedObjectContext)!
                            
                            let museum1 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                            museum1.setValue("Perwomajski", forKey: "districtName")
                            museum1.setValue("Museum1", forKey: "name")
                            
                            let museum2 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                            museum2.setValue("Perwomajski", forKey: "districtName")
                            museum2.setValue("Museum2", forKey: "name")
                            
                            let museum3 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                            museum3.setValue("Moscow", forKey: "districtName")
                            museum3.setValue("Museum3", forKey: "name")
                            
                            let museum4 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                            museum4.setValue("Moscow", forKey: "districtName")
                            museum4.setValue("Museum4", forKey: "name")
                            
                            try managedObjectContext.save()
                        }
                        
                        print(results.count)
                        
                        for data in results as! [NSManagedObject] {
                            
                            if (data.value(forKey: "districtName") as! String) == district.name {
                                museums.append(data.value(forKey: "name") as! String)
                            }
                            
                        }
                    }catch let error as NSError {
                        print("Data loading error: \(error)")
                    }
                    
                    return museums
                }()
                district.latitude = artwork.coordinate.latitude
                district.longitude = artwork.coordinate.longitude
                
                vc.districtDetails = district
            }
        }
    }
    
    func readDataFromDB(){
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "District")
        
        do{
            
            let results = try managedObjectContext.fetch(fetchRequest)
            
            if results.count == 0 {
                print("Nothing was found")
                
                let entity = NSEntityDescription.entity(forEntityName: "District", in: managedObjectContext)!
                
                let district1 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                
                district1.setValue("Perwomajski", forKey: "name")
                district1.setValue(53.935455, forKey: "latitude")
                district1.setValue(27.650697, forKey: "longitude")
                
                let district2 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                
                district2.setValue("Moscow", forKey: "name")
                district2.setValue(53.871803, forKey: "latitude")
                district2.setValue(27.491722, forKey: "longitude")
                
                try managedObjectContext.save()
            }
            
            for data in results as! [NSManagedObject] {
                let coordinate = CLLocationCoordinate2D(latitude: data.value(forKey: "latitude") as! CLLocationDegrees , longitude: data.value(forKey: "longitude") as! CLLocationDegrees)
                let title = data.value(forKey: "name") as! String
                districts[title] = coordinate
                
            }
        }catch let error as NSError {
            print("Data loading error: \(error)")
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            let coordinate = districts[annotationTitle!]
            self.performSegue(withIdentifier: "showDetails", sender: MuseumDetails(title: annotationTitle!, coordinate: coordinate!))
        }
    }
}

