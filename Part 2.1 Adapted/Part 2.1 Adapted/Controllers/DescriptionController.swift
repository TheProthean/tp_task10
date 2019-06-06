//
//  DescriptionController.swift
//  Part 2.1 Adapted
//
//  Created by Anton on 5/25/19.
//  Copyright © 2019 Anton. All rights reserved.
//

import UIKit

class DescriptionController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            guard let image = book?.imageName else {return}
            imageView.image = UIImage(named: image)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = book?.name
        }
    }
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = book?.description
        }
    }
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
