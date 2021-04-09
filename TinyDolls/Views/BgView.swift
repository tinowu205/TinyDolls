//
//  BgView.swift
//  TinyDolls
//
//  Created by tino又想吃肉了 on 2021/4/8.
//

import UIKit

class BgView: UIView {
    
    var scrollView : UIScrollView?
    init(view:UIScrollView ,frame:CGRect) {
        super.init(frame: frame)
        
        scrollView = view
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if(self.point(inside: point, with: event)){
            return scrollView
        }else{
            return self
        }
    }
}
