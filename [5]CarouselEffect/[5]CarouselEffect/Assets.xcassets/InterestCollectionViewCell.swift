//
//  InterestCollectionViewCell.swift
//  [5]CarouselEffect
//
//  Created by Seven on 2018/5/16.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    fileprivate func updateUI() {
        interestTitleLabel?.text! = interest.title
        featuredImageView?.image! = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
