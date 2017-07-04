//
//  EmotionPackageModel.swift
//  EmotionDemo
//
//  Created by landixing on 2017/6/8.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class EmotionPackageModel: NSObject {

    var emoIcons: [EmotionModel]  = [EmotionModel]()
    
    init(id: String) {
        super.init()
        
        //最近分组
        if id == "" {
            addEmptyEmoticon(true)
            return
        }
        
        
        //路径拼接
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        //根据文件路径读取数据
        let array = NSArray(contentsOfFile: plistPath) as! [[String : String]]
        
        
        var index = 0
        for var dic in array {
            //通过key值(png) 拿到图片名字
            if let png = dic["png"] {
                //dic["png"] 保存对应png保存的路径
                dic["png"] = id + "/" + png
            }
    
            emoIcons.append(EmotionModel(dic: dic))
            index += 1
            
            //添加删除表情
            if index == 20 {
                emoIcons.append(EmotionModel(isRemove: true))
                index = 0
            }
        }
        // 5.添加空白表情
        addEmptyEmoticon(false)
    }
    
    
    fileprivate func addEmptyEmoticon(_ isRecently : Bool) {
        let count = emoIcons.count % 21
        if count == 0 && !isRecently {
            return
        }
        for _ in count..<20 {
            emoIcons.append(EmotionModel(isEmpty: true))
        }
        
        emoIcons.append(EmotionModel(isRemove: true))
    }

}
