//
//  EmotionModel.swift
//  EmotionDemo
//
//  Created by landixing on 2017/6/8.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class EmotionModel: NSObject {

    // MARK:- 定义属性
     // emoji的code
    var code : String?{
        didSet{
            guard let code = code else { return  }
            
            // 1.创建扫描器
            let scanner = Scanner(string: code)
            
            // 2.调用方法,扫描出code中的值
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            
            // 3.将value转成字符
            let c = Character(UnicodeScalar(value)!)
            
            // 4.将字符转成字符串
            emojiCode = String(c)        
        }
    }
     // 普通表情对应的图片名称
    var png : String? {
        didSet{
            guard let png = png else { return  }
        
            pngPath = Bundle.main.bundlePath +  "/Emoticons.bundle/" + png
            
        }
    }
    var chs : String?     // 普通表情对应的文字
    var gif : String?     // gif
    
    
    
    
    
    // MARK:- 数据处理
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false //删除按钮
    var isEmpty : Bool = false //空白表情
    
    init(dic: [String : String]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    init(isRemove: Bool) {
        self.isRemove = isRemove
    }
    
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["code", "pngPath", "chs","gif"]).description
    }
    

}
