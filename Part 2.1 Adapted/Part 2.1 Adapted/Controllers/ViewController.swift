//
//  ViewController.swift
//  Part 2.1 Adapted
//
//  Created by Anton on 5/25/19.
//  Copyright © 2019 Anton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var bookArray: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        let path = Bundle.main.path(forResource: "books", ofType: "plist")!
        let data = NSArray(contentsOfFile: path) as! [NSDictionary]
        for dbook in data {
            var book: Book = Book(name: "", imageName: "", description: "")
            book.description = dbook.object(forKey: "description") as? String
            book.name = dbook.object(forKey: "name") as? String
            book.imageName = dbook.object(forKey: "imageName") as? String
            bookArray.append(book)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDescription" {
            if let descriptionController = segue.destination as? DescriptionController {
                let book = sender as? Book
                print(book ?? "nil")
                descriptionController.book = book
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            let book = bookArray[indexPath.row]
            bookCell.menu = book
            return bookCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookArray[indexPath.row]
        self.performSegue(withIdentifier: "showDescription", sender: book)
    }
    


}

