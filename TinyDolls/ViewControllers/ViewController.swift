//
//  ViewController.swift
//  TinyDolls
//
//  Created by tino又想吃肉了 on 2021/4/8.
//

import UIKit
protocol UpdateWorry : class {
    func makeNewWorry(worry:Dolls)
}
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UpdateWorry {
    
    let SrceenWidth = UIScreen.main.bounds.size.width
    let SrceenHeight = UIScreen.main.bounds.size.height
    
    var bgView : BgView?
    
    var cnt = 0
    
    var dollsView : UICollectionView?
    
    var model : Array<Dolls>?
    
    var addVC : AddWorryController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavBar()
        layoutViews()
        setupBtns()
        getData()
        self.view.backgroundColor = UIColor.white
        
        
    }
    // MARK: setup data
    func getData() {
        model = Array<Dolls>()
    }
    
    // MARK: layout views firstly
    
    func layoutViews() {
        // MARK: backGround
        let bgView = UIImageView(image: UIImage(named: "background"))
        //self.view.addSubview(bgView)
        
        // MARK: scrollView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 180)
        
        dollsView = UICollectionView(frame: CGRect(x: 0, y: 200, width: self.SrceenWidth, height: 280), collectionViewLayout: layout)
        dollsView?.alwaysBounceHorizontal = true
        
        dollsView?.backgroundView = bgView
        
        dollsView?.delegate = self
        dollsView?.dataSource = self
        dollsView?.register(DollViewCell.self, forCellWithReuseIdentifier: "cell")
        
        //dollsView?.isPagingEnabled = true
        
        self.view.addSubview(dollsView!)
    }
    
    func resizeImage(image:UIImage, size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resized ?? UIImage()
    }
    
    func setNavBar() {
        let titleImage = resizeImage(image: UIImage(named: "title")!, size: CGSize(width: 200, height: 50))
        let titleImageView = UIImageView(image: titleImage)
        
        self.navigationItem.titleView = titleImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    // MARK: buttons
    func setupBtns() {
        // leftBtn
        let leftButton = UIBarButtonItem(systemItem: .add)
        self.navigationItem.leftBarButtonItem = leftButton
        leftButton.action = #selector(clickBut(btn:))
        leftButton.target = self
        
        // addBtn
        let plusBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 25 , y: UIScreen.main.bounds.size.height - 100, width: 40, height: 40))
        plusBtn.setImage(UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)), for: .normal)
        plusBtn.addTarget(self, action: #selector(addDoll), for: .touchUpInside)
        
        self.view.addSubview(plusBtn)
        
        // MARK: left bar buttn
        let backBtn = UIBarButtonItem()
        backBtn.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal, barMetrics: .default)
        backBtn.target = self
        backBtn.action = #selector(popVC)
        
        self.navigationItem.backBarButtonItem = backBtn
    }
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickBut(btn:UIBarButtonItem) {
        
    }
    
    // MARK: add doll
    @objc func addDoll() {
        
        addVC = AddWorryController()
        addVC?.delegate = self
        
        self.navigationController?.present(addVC!, animated: true, completion: nil)
        
        //dollsView?.reloadData()
    }
    
    // MARK: uicollectionview delegate & datasource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let index = indexPath.row
        let doll = model?[index]
        
        let vc = DetailViewController()
        vc.title = "我正在烦恼，因为..."
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.model = doll
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return model?.count ?? 0
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DollViewCell
        let doll = model?[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(doll?.dollNum ?? 0)")
        
        return cell
    }
    
    // MARK: worry delegate
    func makeNewWorry(worry:Dolls){
        print(worry)
        model?.append(worry)
        dollsView?.reloadData()
    }
}

