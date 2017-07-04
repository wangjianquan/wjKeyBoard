//
//  CustomPhotoCell.swift
//  CustomKeyboard
//
//  Created by landixing on 2017/6/16.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit
private let btnWH  : CGFloat = 20
private let margin : CGFloat = 5
class CustomPhotoCell: UICollectionViewCell {
    
    var seleBtn : UIButton = {
    
        let btn : UIButton = UIButton()
        btn.setImage(UIImage(named: "compose_photo_preview_right"), for: .normal)
        btn.setImage(UIImage(named: "compose_photo_preview_right"), for: .selected)
//        btn.sizeToFit()
        return btn
    }()
    var imageView : UIImageView = {
        let imageview : UIImageView = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview

    }()
    
    var image : UIImage?
    {
        didSet{
        
            guard let image = image else { return
            }
            
            self.imageView.image = image
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
}

extension  CustomPhotoCell {

    fileprivate func setupUI() {
    
        contentView.addSubview(imageView)
        imageView.addSubview(seleBtn)

        imageView.frame = contentView.bounds
        seleBtn.frame = CGRect(x: imageView.frame.width - btnWH - margin, y: margin, width: btnWH, height: btnWH)


    }

}



































