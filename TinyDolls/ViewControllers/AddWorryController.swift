//
//  AddWorryController.swift
//  TinyDolls
//
//  Created by tino又想吃肉了 on 2021/4/9.
//

import UIKit

class AddWorryController: UIViewController,UITextViewDelegate {
    
    let SrceenWidth = UIScreen.main.bounds.size.width
    let SrceenHeight = UIScreen.main.bounds.size.height
    
    weak var delegate : UpdateWorry?
    
    var textView : UITextView?
    
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        
        layoutViews()
    }
    
    func layoutViews() {
        
        // MARK: background & doll
        let bg = UIImageView(image: UIImage(named: "background"))
        bg.frame = CGRect(x: 0, y: 0, width: SrceenWidth, height: 280)
        bg.isUserInteractionEnabled = true
        
        index = Int(arc4random_uniform(3))
        let doll = UIImageView(image: UIImage(named: "\(index)"))
        doll.frame = CGRect(x: SrceenWidth/2 - 40, y: 120, width: 80, height: 180)
        bg.addSubview(doll)
        self.view.addSubview(bg)
        
        // MARK: back button
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        bg.addSubview(btn)
        
        // MARK: textview
        textView = UITextView(frame: CGRect(x: 30, y: doll.frame.maxY + 120, width: SrceenWidth - 60 , height: 150))
        textView?.text = "请告诉我你的烦恼吧..."
        textView?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView?.delegate = self
        
        self.view.addSubview(textView!)
        
        // MARK: done button
        let done = UIButton(frame: CGRect(x: SrceenWidth/2 - 30, y: (textView?.frame.maxY)! + 50, width: 60, height: 40))
        self.view.addSubview(done)
        done.addTarget(self, action: #selector(doneTexting), for: .touchUpInside)
        done.setBackgroundImage(UIImage(systemName: "keyboard.chevron.compact.down"), for: .normal)
        
        // MARK: title
        let titleLabel = UILabel(frame: CGRect(x: SrceenWidth/2-75, y: 10, width: 150, height: 40))
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 7))
        titleLabel.textAlignment = .center
        titleLabel.text = "让我替你烦恼吧"
        self.view.addSubview(titleLabel)
    }

    @objc func dismissVC() {
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneTexting() {
        print("done")
        if textView?.text == "" {
            self.dismiss(animated: true, completion: nil)
            return
        }
        let doll = Dolls(worry: (textView?.text)!, dollNum: index)
        self.delegate?.makeNewWorry(worry: doll)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: textview delegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        textView.text = ""
        
        return true
    }
}
