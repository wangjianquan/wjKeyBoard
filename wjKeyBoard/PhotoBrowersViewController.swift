//
//  PhotoBrowersViewController.swift
//  CustomKeyboard
//
//  Created by landixing on 2017/6/16.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class PhotoBrowersViewController: UIViewController {
    var imageView : UIImageView = {
        let imageview : UIImageView = UIImageView()
        imageview.contentMode = .scaleAspectFit
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
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        displayPhoto()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}

extension PhotoBrowersViewController {

    fileprivate func setupUI() {
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(PhotoBrowersViewController.back))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(PhotoBrowersViewController.deleteImage))
    
    
    
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 64)
    }
    
    
   fileprivate func displayPhoto() {
       
        
    }
    
}
extension PhotoBrowersViewController {
    
  @objc  fileprivate func back() {
        
    
    }
    @objc  fileprivate func deleteImage() {
        navigationController?.popViewController(animated: true)
        
    }
    
}






















