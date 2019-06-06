//
//  DetailsViewController.swift
//  task2
//
//  Created by Anton on 5/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.text = districtDetails?.name
           // print("name: \(districtDetails?.name)")
        }
    }
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cafeImage: UIImageView!
    
    var districtDetails: CurCafeInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherGetter.getTemperature(latitude: (districtDetails?.latitude)!, longitude: (districtDetails?.longitude)!, completition: viewWeather)
        
        descLabel.text = districtDetails?.desc
        cafeImage.image = UIImage.init(named: (districtDetails?.name)!)
    }
    
    func viewWeather(temperature:Double){
        self.weatherLabel.text = "Temperature: \(temperature)"
        
    }
    
}
