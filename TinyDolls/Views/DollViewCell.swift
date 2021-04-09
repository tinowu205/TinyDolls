//
//  DollViewCell.swift
//  TinyDolls
//
//  Created by tino又想吃肉了 on 2021/4/9.
//

import UIKit

class DollViewCell: UICollectionViewCell {
    
    var imageView : UIImageView?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.imageView = UIImageView(frame: self.bounds)
        
        self.addSubview(imageView!)
    }
    
}
