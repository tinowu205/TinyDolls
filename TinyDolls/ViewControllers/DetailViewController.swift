//
//  DetailViewController.swift
//  TinyDolls
//
//  Created by tino又想吃肉了 on 2021/4/9.
//

import UIKit

class DetailViewController: UIViewController {
    
    let SrceenWidth = UIScreen.main.bounds.size.width
    let SrceenHeight = UIScreen.main.bounds.size.height
    
    let index : Int = 0
    
    var textlabel : UILabel? = nil
    
    var model : Dolls? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layoutViews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: layout views
    func layoutViews() {
        
        // MARK: background & doll
        let bg = UIImageView(image: UIImage(named: "background"))
        self.view.addSubview(bg)
        
        // MARK: doll
        let doll = UIImageView(image: UIImage(named: "\(model?.dollNum ?? 0)"))
        doll.frame = CGRect(x: SrceenWidth/2 - 40, y: 230, width: 80, height: 180)
        bg.addSubview(doll)
        
        // MARK: label
        textlabel = UILabel(frame: CGRect(x: 30, y: doll.frame.maxY + 30, width: SrceenWidth - 60 , height: 100))
        textlabel?.text = model?.worry
        textlabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textlabel?.textAlignment = .center
        bg.addSubview(textlabel!)
        //textlabel?.backgroundColor = .blue
    }
    
}
