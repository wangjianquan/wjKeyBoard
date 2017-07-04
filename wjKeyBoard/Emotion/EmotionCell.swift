//
//  EmotionCell.swift
//  EmotionDemo
//
//  Created by landixing on 2017/6/8.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class EmotionCell: UICollectionViewCell {
    
    fileprivate lazy var emotionBtn: UIButton = UIButton()
    
    
    var emotionModel : EmotionModel?
    {
        didSet{
            guard let emotion = emotionModel else {  return  }
                    emotionBtn.setImage(UIImage(contentsOfFile: emotion.pngPath ?? ""), for: .normal)
                    emotionBtn.setTitle(emotion.emojiCode, for: .normal)
            
            //设置删除按钮
            if emotion.isRemove {
                emotionBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)

            }
    
        }
    
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmotionCell {

  fileprivate  func setupUI() {
        contentView.addSubview(emotionBtn)
        
        emotionBtn.frame = contentView.frame
        
        emotionBtn.isUserInteractionEnabled = false
        
        emotionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }



}
