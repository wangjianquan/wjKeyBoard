//
//  ViewController.swift
//  wjKeyBoard
//
//  Created by landixing on 2017/6/16.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit
import SnapKit

private let tooBar_W = UIScreen.main.bounds.width
private let tooBar_H = 44
private let tooBar_Y = Int(UIScreen.main.bounds.size.height) - tooBar_H

class ViewController: UIViewController,btnClickDelegate {
    
    fileprivate lazy var names: [String]? = {
        return ["compose_toolbar_picture","compose_trendbutton_background","compose_mentionbutton_background","compose_emoticonbutton_background","compose_keyboardbutton_background"]
    }()
    
    fileprivate lazy var toolbar: CustomToolbar = {
        let toolbar = CustomToolbar(frame: CGRect(x: 0, y: tooBar_Y, width: Int(tooBar_W), height: tooBar_H))
       
        if let imageNames = self.names {
            toolbar.imageNames = imageNames
        }
        toolbar.delegate = self
        return toolbar
    }()
    
    fileprivate lazy var customTextView: ComposeTextView = {
        let  customTextView: ComposeTextView = ComposeTextView()
        customTextView.delegate = self
        customTextView.alwaysBounceVertical = true//设置文字没超出自身高度时仍可以滚动
        return customTextView
    }()
    
    fileprivate lazy var picPickerView: PicPickerViewContro = PicPickerViewContro(collectionViewLayout: layout())
    
    fileprivate lazy var emoticonVc : EmotionViewController = EmotionViewController {[weak self] (emoticon) -> () in
        self?.customTextView.insertEmoticon(emoticon)
        self?.textViewDidChange((self?.customTextView)!)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customTextView.becomeFirstResponder()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化textView
        setupTextView()
        //初始化照片选择器
        setupPicPickerView()
        
        //监听键盘弹出高度
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController {
    //MARK: -- 初始化textView
    fileprivate func setupTextView() {
        view.addSubview(customTextView)
        view.insertSubview(toolbar, aboveSubview: customTextView)
        customTextView.snp.makeConstraints({ (make) in
                make.top.equalTo(0)
                make.left.right.equalTo(0)
                make.bottom.equalTo(0)
            })
    }
    //MARK: -- 初始化照片选择器
    func setupPicPickerView()  {
        view.insertSubview(picPickerView.view, belowSubview: toolbar)
        //功能: 注释试试(注释后选择照片之后,picPickerView不见了)
        addChildViewController(picPickerView)
        picPickerView.view.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(0)
        })
        //键盘退出
        picPickerView.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(_:))))
    }

    //显示照片选择器
    fileprivate func shouPickerView() {
        customTextView.resignFirstResponder()
        picPickerView.view.snp.remakeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.view).multipliedBy(0.65)
        }
        UIView.animate(withDuration: 1.5) { 
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController{
    
    func btnClick(btn: UIButton, tag: Int) {
        switch tag {
        case 0:
            //打开相册
            self.picPickerView.imagePickerControll()
            //显示照片选择
            self.shouPickerView()
        break;
            
        case 1:
            break;
        case 2:
            break;
        case 3:
            btn.isSelected = !btn.isSelected
            customTextView.resignFirstResponder()
            customTextView.inputView = customTextView.inputView != nil ? nil : emoticonVc.view
            customTextView.becomeFirstResponder()
            
            break;
        case 4:
            
            if customTextView.inputView == emoticonVc.view{
                customTextView.resignFirstResponder()
                customTextView.inputView = nil
                customTextView.becomeFirstResponder()
            }
           
            
            break;
            
        default:
            break
        }
        
    }
    
    @objc fileprivate func keyboardWillChangeFrame(_ note: Notification){
        
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        toolbar.frame = CGRect(x: 0, y: Int(endFrame.origin.y) - tooBar_H, width: Int(tooBar_W), height: tooBar_H)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            
        }
    }

    @objc fileprivate func dismissKeyBoard(_ tap: UITapGestureRecognizer) {
        self.customTextView.resignFirstResponder()
    }
}

//MARK: -- 代理方法

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.customTextView.placeHolderLabel.isHidden = textView.hasText
        print("\(self.customTextView.getEmoticonString())")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.customTextView.resignFirstResponder()
    }
}





