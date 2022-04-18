//
//  ViewController.swift
//  MasonryDemo
//
//  Created by 翁燮羽 on 2022/4/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageNames = [UIImage(named: "01"),UIImage(named: "02"),UIImage(named: "03")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    func initUI() {
        collectionViewSetUp()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,PinterestLayoutDelegate {
    
    func collectionViewSetUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? PintersetLayout {
            layout.delegate = self
        }
        
        let nib = UINib(nibName: "\(CollectionViewCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell else {
            print("Viewcontroller Get cell fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(image: imageNames[indexPath.item]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        guard var height = imageNames[indexPath.item]?.size.height else {
            print("collectionView layout get fail")
            return 0
        }
        
        if height > 1000{
            height =  height * 0.2
            return height
        }else{
            height = height * 0.3
            return height
        }
    }
    
}
