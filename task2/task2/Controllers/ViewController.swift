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

    var cafes: [String: CLLocationCoordinate2D] = [:]
    
    var isbel: Bool = true
    var isusa: Bool = true
    var isgeorgia: Bool = true
    
    func centerMapOnLocation(location: CLLocation) {
        locationManager.delegate = self
        mapView.delegate = self
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

        for cafe in cafes {
            print(cafe)
            mapView.addAnnotation(CafeDetails(title: cafe.key, coordinate: cafe.value))
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
                let artwork = sender as! CafeDetails
                var cafe = CurCafeInfo()
                cafe.name = artwork.title
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedObjectContext = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cafe")
                
                do{
                    
                    let results = try managedObjectContext.fetch(fetchRequest)
                    
                    print(results.count)
                    
                    for data in results as! [NSManagedObject] {
                        
                        if (data.value(forKey: "name") as! String) == cafe.name {
                            cafe.desc = data.value(forKey: "desc") as? String
                            cafe.type = data.value(forKey: "type") as? String
                            break
                        }
                        
                    }
                }catch let error as NSError {
                    print("Data loading error: \(error)")
                }
                
                cafe.latitude = artwork.coordinate.latitude
                cafe.longitude = artwork.coordinate.longitude
                
                vc.cafeDetails = cafe
                vc.isbel = self.isbel
                vc.isusa = self.isusa
                vc.isgeorgia = self.isgeorgia
            }
        }
    }
    
    func readDataFromDB(){
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cafe")
        
        do{
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try managedObjectContext.execute(deleteRequest)
            
            var results = try managedObjectContext.fetch(fetchRequest)
            
            if results.count == 0 {
                print("Nothing was found")
                
                let entity = NSEntityDescription.entity(forEntityName: "Cafe", in: managedObjectContext)!
                
                if isbel == true {
                    let cafe1 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe1.setValue("I'm dranik", forKey: "name")
                    cafe1.setValue(53.935455, forKey: "lat")
                    cafe1.setValue(27.650697, forKey: "lon")
                    cafe1.setValue("Belarusian", forKey: "type")
                    cafe1.setValue("Draniki mmm...", forKey: "desc")
                    
                    let cafe2 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe2.setValue("I'm babka", forKey: "name")
                    cafe2.setValue(53.881803, forKey: "lat")
                    cafe2.setValue(27.551722, forKey: "lon")
                    cafe2.setValue("Belarusian", forKey: "type")
                    cafe2.setValue("Potato is my life...", forKey: "desc")
                }
                
                if isusa == true {
                    let cafe1 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe1.setValue("Texas Chicken", forKey: "name")
                    cafe1.setValue(53.905455, forKey: "lat")
                    cafe1.setValue(27.630697, forKey: "lon")
                    cafe1.setValue("American", forKey: "type")
                    cafe1.setValue("Coca-cola and chicken - mmm...", forKey: "desc")
                    
                    let cafe2 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe2.setValue("Mcdonalds", forKey: "name")
                    cafe2.setValue(53.871803, forKey: "lat")
                    cafe2.setValue(27.491722, forKey: "lon")
                    cafe2.setValue("American", forKey: "type")
                    cafe2.setValue("Burgers mmm...", forKey: "desc")
                }
                
                if isgeorgia == true {
                    let cafe1 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe1.setValue("Natfris He", forKey: "name")
                    cafe1.setValue(53.885455, forKey: "lat")
                    cafe1.setValue(27.620697, forKey: "lon")
                    cafe1.setValue("Georian", forKey: "type")
                    cafe1.setValue("Why such a name? Natvris Heh! What does it mean? A: Dream Tree", forKey: "desc")
                    
                    let cafe2 = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                    
                    cafe2.setValue("Tiflis", forKey: "name")
                    cafe2.setValue(53.931803, forKey: "lat")
                    cafe2.setValue(27.591722, forKey: "lon")
                    cafe2.setValue("Georian", forKey: "type")
                    cafe2.setValue("Hinkalinka omnomnom...", forKey: "desc")
                }
                
                try managedObjectContext.save()
                
                results = try managedObjectContext.fetch(fetchRequest)
            }
            
            
            for data in results as! [NSManagedObject] {
                let coordinate = CLLocationCoordinate2D(latitude: data.value(forKey: "lat") as! CLLocationDegrees , longitude: data.value(forKey: "lon") as! CLLocationDegrees)
                let title = data.value(forKey: "name") as! String
                cafes[title] = coordinate
                
            }
        }catch let error as NSError {
            print("Data loading error: \(error)")
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            let coordinate = cafes[annotationTitle!]
            self.performSegue(withIdentifier: "showDetails", sender: CafeDetails(title: annotationTitle!, coordinate: coordinate!))
        }
    }
}

