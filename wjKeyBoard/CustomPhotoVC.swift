//
//  CustomPhotoVC.swift
//  wjKeyBoard
//
//  Created by landixing on 2017/6/16.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let photoCellIdentifier = "cell"
private let margin = 1
private let amlumName = "he he"

class CustomPhotoVC: UIViewController {
    
        var collectionview : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CustomPhotoFlowLayout())

        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupUI()
        }
    




}
extension CustomPhotoVC{
    
    fileprivate func setupUI() {
        view.addSubview(collectionview)
        collectionview.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height-64)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CustomPhotoCell.self, forCellWithReuseIdentifier: photoCellIdentifier)
        
    }
    
    fileprivate func loadAsset() {
        
        
    }
    
}
extension CustomPhotoVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! CustomPhotoCell
        cell.image = UIImage(named: "ivy_chen.jpg")
        
        
        return cell
    }
}

extension CustomPhotoVC : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoBrowersVC = PhotoBrowersViewController()
      
        navigationController?.pushViewController(photoBrowersVC, animated: true)
        
        
    }
}



class CustomPhotoFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemW = (UIScreen.main.bounds.width - 3) / 4
        let itemH = itemW
        itemSize = CGSize(width: itemW, height: itemH)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 0
        scrollDirection = .vertical
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(margin), right: 0)
        
    }
    
}
