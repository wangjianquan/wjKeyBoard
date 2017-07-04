//
//  EmotionViewController.swift
//  EmotionDemo
//
//  Created by landixing on 2017/6/8.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let identifier = "cell"
class EmotionViewController: UIViewController {

     // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionFlowLayout())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager = EmotionManager()
 
    // MARK:- 定义属性
    var emotionCallBack : (_ emoicon: EmotionModel) -> ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //自定义构造函数
    init(emotionCallBack: @escaping (_ emoicon: EmotionModel) -> ()) {
        self.emotionCallBack = emotionCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}


//MARK : -- UI设置
extension EmotionViewController {

    fileprivate func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.init(white: 0.97, alpha: 1.0)
        toolBar.backgroundColor = UIColor.white
        toolBar.tintColor = UIColor.orange

        
        //VFL设置约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints =   false
        let views = ["toolBar" : toolBar, "collectionView" : collectionView] as [String : Any]
        
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
      
        collectionIdentifier()
        setupToolBar()
    }
    
    
    
    fileprivate func collectionIdentifier () {
      collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    
    }
    
    fileprivate func setupToolBar() {
        let titles = ["最近","默认", "emoji", "浪小花"]
        
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(EmotionViewController.toolBarClick(_:)))
            item.tag = index
            index += 1
//            item.backgroundImage(for: .selected, barMetrics: .compactPrompt)
//            item.backgroundImage(for: .normal, barMetrics: .default)
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)) //间距
        }
        tempItems.removeLast()
        toolBar.items = tempItems
    }
}

extension EmotionViewController {
    @objc fileprivate func toolBarClick(_ item: UIBarButtonItem) {
    
        let tag = item.tag
      
        let indexPath = IndexPath(item: 0, section: tag)
        
    collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }

}

extension EmotionViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let packpage = manager.packages[section]
        return packpage.emoIcons.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! EmotionCell

        let package = manager.packages[indexPath.section]
        
        let emotion = package.emoIcons[indexPath.item]
        
        cell.emotionModel = emotion
        return cell
        
    }
    
}

extension EmotionViewController : UICollectionViewDelegate{
    //选中单元格
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = manager.packages[indexPath.section]
        let emotion = package.emoIcons[indexPath.item]
        // 2.将点击的表情插入最近分组中
        manager.insertRecentlyEmoicon(emotion)
        
        // 3.将表情回调给外界控制器
        emotionCallBack(emotion)
    }
}

class EmotionFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let  itemWH = UIScreen.main.bounds.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let margin = (collectionView!.bounds.height - 3 * itemWH)/2
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
    }
}





