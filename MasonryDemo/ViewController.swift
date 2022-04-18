//
//  ViewController.swift
//  MasonryDemo
//
//  Created by 翁燮羽 on 2022/4/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageNames = ["01","02","03"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    func initUI() {
        collectionViewSetUp()
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionViewSetUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        
        cell.convertCell(imageName: imageNames[indexPath.item])
        
        return cell
    }
    
    
    
}
