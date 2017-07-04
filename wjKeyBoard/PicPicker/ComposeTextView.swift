//
//  ComposeTextView.swift
//  weibo_wjq
//
//  Created by landixing on 2017/6/6.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {

    lazy var placeHolderLabel : UILabel = UILabel()
    var fontSize: CGFloat?
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        if let fontsize = fontSize {
            self.font = UIFont.systemFont(ofSize: fontsize)
        }
        self.font = UIFont.systemFont(ofSize: 16)
        setupPlaceHolder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupPlaceHolder()
    }


}


extension ComposeTextView {
    
    fileprivate func setupPlaceHolder() {
        addSubview(placeHolderLabel)
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.leading.equalTo(10)
        }
        placeHolderLabel.text = "分享新鲜事..."
        placeHolderLabel.textColor = UIColor.lightGray
        
        textContainerInset = UIEdgeInsets(top: 8, left: 7, bottom: 0, right: 10)
    }
}









