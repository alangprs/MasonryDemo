//
//  CollectionViewCell.swift
//  MasonryDemo
//
//  Created by 翁燮羽 on 2022/4/17.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    func convertCell(image: UIImage) {
        cellImageView.image = image
        self.backgroundColor = .red
    }

}
