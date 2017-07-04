//
//  CustomToolbar.swift
//  wjKeyBoard
//
//  Created by landixing on 2017/6/30.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit



protocol btnClickDelegate: NSObjectProtocol {
    func btnClick(btn: UIButton, tag: Int)
}

class CustomToolbar: UIView {

    weak var delegate: btnClickDelegate?
    
    var imageNames: [String]{
        didSet{
             let btnWH = 40
            //间隔
            let margin = (Int(self.bounds.size.width) - imageNames.count * btnWH) / (imageNames.count + 1)
            for i in 0..<imageNames.count {
              let btn = UIButton(frame: CGRect(x: (btnWH + margin)*i + margin, y: 0, width: btnWH, height: Int(self.bounds.size.height)))

                btn.setImage(UIImage(named:imageNames[i]), for: .normal)
                 btn.setImage(UIImage(named:imageNames[i]+"_highlighted"), for: .selected)
                btn.tag = i
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                self.addSubview(btn)
            }
        }
    }
     
    
    override init(frame: CGRect) {
        self.imageNames = [String]()
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
    
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension CustomToolbar {

    @objc fileprivate func btnClick(_ sender: UIButton) {
        delegate?.btnClick(btn: sender, tag: sender.tag)
    }

}
