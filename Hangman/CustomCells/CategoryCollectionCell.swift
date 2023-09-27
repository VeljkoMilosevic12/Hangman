//
//  CategoryCollectionCell.swift
//  HangmanPro
//
//  Created by Veljko Milosevic on 26/01/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }

}
