//
//  MenuCollectionViewCell.swift
//  Part 2.1 Adapted
//
//  Created by Anton on 5/25/19.
//  Copyright © 2019 Anton. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var menu: Book? {
        didSet{
            nameLabel.text = menu?.name
            if let image = menu?.imageName {
                imageView.image = UIImage(named: image)
            }
        }
    }
}
