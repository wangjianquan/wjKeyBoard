//
//  PicPickViewContro.swift
//  wjKeyBoard
//
//  Created by landixing on 2017/6/29.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let edgeMargin : CGFloat = 8
private let imageMargin : CGFloat = 8


class PicPickerViewContro: UICollectionViewController {
    
    //图片数组
    var images: [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
//        self.collectionView?.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func imagePickerControll() {
        if !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            return
        }
        
        let  pickerControll = UIImagePickerController()
        
        pickerControll.sourceType = .savedPhotosAlbum
        
        pickerControll.delegate = self
        
        present(pickerControll, animated: true, completion: nil)
    }
    
    
}

// MARK: UICollectionViewDelegate
class layout : UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        let imageHW = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * imageMargin) / 3
        itemSize = CGSize(width: imageHW, height: imageHW)
        minimumLineSpacing = imageMargin
        minimumInteritemSpacing = imageMargin
        
        collectionView?.contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
        collectionView?.backgroundColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1.0)
        
        
    }
    
}

// MARK: UICollectionViewDataSource
extension PicPickerViewContro{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PicCollectionViewCell
        
        cell.delegate = self
        cell.image = indexPath.item < images.count ? images[indexPath.item] : nil
        
        return cell
    }
    
}



extension PicPickerViewContro: picCellDelegate {
    
    func picPickerViewCellWithAddPhoto(_ cell: PicCollectionViewCell) {
        imagePickerControll()
        
    }

    func picPickerViewCellWithRemovePhoto(_ cell: PicCollectionViewCell) {
        let index = (collectionView?.indexPath(for: cell))!
        
        images.remove(at: index.item)
        
        collectionView?.reloadData()
    }

}

extension PicPickerViewContro : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        collectionView?.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
