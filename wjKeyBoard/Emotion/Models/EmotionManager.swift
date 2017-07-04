//
//  EmotionManager.swift
//  EmotionDemo
//
//  Created by landixing on 2017/6/8.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class EmotionManager {

    var packages : [EmotionPackageModel] = [EmotionPackageModel]()
    
     init () {
        // 1.添加最近表情的包
        packages.append(EmotionPackageModel(id: ""))
        
        // 2.添加默认表情的包
        packages.append(EmotionPackageModel(id: "com.sina.default"))
        
        // 3.添加emoji表情的包
        packages.append(EmotionPackageModel(id: "com.apple.emoji"))
        
        // 4.添加浪小花表情的包
        packages.append(EmotionPackageModel(id: "com.sina.lxh"))
    }
    
    //MARK: -- 添加到"最近"分组中
     func insertRecentlyEmoicon(_ emotion: EmotionModel){
        //如果是空白或者删除按钮,不需要插入
        if emotion.isRemove || emotion.isEmpty {
            return
        }
        
        if packages.first!.emoIcons.contains(emotion) {
            // 原来有该表情
            let index = (packages.first?.emoIcons.index(of: emotion))!
            packages.first?.emoIcons.remove(at: index)
        } else {
            // 原来没有这个表情
            packages.first?.emoIcons.remove(at: 19)
        }
        
        //添加点击的表情到"最近"分组的第0个位置
        packages.first?.emoIcons.insert(emotion, at: 0)
        
        
        
    }
}
