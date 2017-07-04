//
//  PicCollectionViewCell.swift
//  wjKeyBoard
//
//  Created by landixing on 2017/6/29.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let deleteBtnWH: CGFloat = 23

protocol picCellDelegate: NSObjectProtocol {
    func picPickerViewCellWithAddPhoto(_ cell:PicCollectionViewCell )

    func picPickerViewCellWithRemovePhoto(_ cell:PicCollectionViewCell )
}

class PicCollectionViewCell: UICollectionViewCell {
    
    //添加按钮
    fileprivate lazy  var addBtn: UIButton = {
        let btn : UIButton = UIButton()
        btn.setImage(UIImage(named:"compose_pic_add"), for: .normal)
        btn.setImage(UIImage(named:"compose_pic_add_highlighted"), for: .highlighted)
        
        btn.contentMode = .scaleToFill
        btn.addTarget(self, action: #selector(PicCollectionViewCell.addBtnAction), for: .touchUpInside)
        return btn
    }()
    //删除按钮
    fileprivate lazy  var deleteBtn: UIButton = {
        let btn : UIButton = UIButton()
        btn.setImage(UIImage(named:"compose_photo_close"), for: .normal)
        
        btn.addTarget(self, action: #selector(PicCollectionViewCell.deleteAction), for: .touchUpInside)
        return btn
    }()
    //imageView
    fileprivate lazy var picImage: UIImageView = {
    
        let imageView : UIImageView = UIImageView()
        
        return imageView
    }()

    weak var delegate: picCellDelegate?
    
    var image: UIImage?{
        didSet{
            picImage.image = image
            picImage.contentMode = .scaleAspectFill
            picImage.clipsToBounds = true
            picImage.isHidden = image == nil
            deleteBtn.isHidden = image == nil
            addBtn.isUserInteractionEnabled = image == nil
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PicCollectionViewCell {

    fileprivate func setupUI(){
      
        contentView.addSubview(addBtn)
        contentView.insertSubview(picImage, aboveSubview: addBtn)
         contentView.insertSubview(deleteBtn, aboveSubview: picImage)
        
        
        picImage.frame = contentView.bounds
        addBtn.frame = contentView.bounds
        deleteBtn.frame = CGRect(x: contentView.bounds.size.width - deleteBtnWH - 8, y: 8, width: deleteBtnWH, height: deleteBtnWH)
        
    
    }
    
    @objc fileprivate func addBtnAction(){
        delegate?.picPickerViewCellWithAddPhoto(self)
    }

    @objc fileprivate func deleteAction(){
        delegate?.picPickerViewCellWithRemovePhoto(self)

    }
}
