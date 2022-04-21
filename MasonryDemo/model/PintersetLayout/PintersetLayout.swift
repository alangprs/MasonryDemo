//
//  PintersetLayout.swift
//  MasonryDemo
//
//  Created by 翁燮羽 on 2022/4/18.
//

import UIKit

protocol PinterestLayoutDelegate{
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}


class PintersetLayout: UICollectionViewLayout {

    var delegate: PinterestLayoutDelegate!

    ///每排cell數量
    private var numberOfColumns = 2
    ///cell之間距離
    private var cellSpacing: CGFloat = 1
    ///計算後layout暫存
    private var caches = [UICollectionViewLayoutAttributes]()
    ///內容物高度
    private var contentHeight: CGFloat = 0
    ///取得collectionView內容寬度
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            print("PintersetLayout get collectionView fial")
            return 0
        }
        return collectionView.bounds.width
    }
 
    //將取得的collectionView size複寫
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
         
        guard caches.isEmpty == true,
              let collectionView = collectionView else {
            return
        }
         
        ///列 寬度
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
         
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
             
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellSpacing * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellSpacing, dy: cellSpacing)
            
             
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            caches.append(attributes)
            
             
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in caches {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return caches[indexPath.item]
    }

}
