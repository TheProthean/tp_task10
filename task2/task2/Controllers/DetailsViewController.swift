//
//  DetailsViewController.swift
//  task2
//
//  Created by Anton on 5/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.text = districtDetails?.name
           // print("name: \(districtDetails?.name)")
        }
    }
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    var districtDetails: DistrictDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherGetter.getTemperature(latitude: (districtDetails?.latitude)!, longitude: (districtDetails?.longitude)!, completition: viewWeather)
        // Do any additional setup after loading the view.
    }
    
    func viewWeather(temperature:Double){
        self.weatherLabel.text = "Temperature: \(temperature)"
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (districtDetails?.museums.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifire = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire)
        
        if(cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifire)
        }
        
        cell?.textLabel?.text = districtDetails?.museums[indexPath.row]
        
        return cell!
    }
    
}
