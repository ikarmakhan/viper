//
//  BaseVC.swift
//  WanaSell
//
//  Created by  on 14/04/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var baseVM:BaseModeling! {
        didSet {
            self.baseVM.showLogoutMessage = {[weak self] message in
            }
            
            self.baseVM.showError = {[weak self] message in
            }
            
            self.baseVM.restartAppFromSplash = {
            }
            
            self.baseVM.removeTransparentVC = {[weak self] in
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseVM = BaseVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navController = navigationController, let _ = navController.interactivePopGestureRecognizer {
            navController.interactivePopGestureRecognizer!.delegate = self
            // To Handle the broken navigationController back swipe
        }
        
        
        baseVM.addObservers()
        
    }
    override func viewWillDisappear (_ animated: Bool) {
        super.viewWillDisappear (animated)
        baseVM.removeObservers()
    }
    
    deinit {
        print("Deinit")
    }
    
    
    
    @IBAction func backButtonAction () {
        navigationBackBtnAction()
    }
    
    public func toggleNavigationBar (shouldShow:Bool, animated:Bool = true) {        
        self.navigationController?.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.setNavigationBarHidden(!shouldShow, animated: animated)
    }
    
    func hideLeftNavigationsBarButtons() {
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.setHidesBackButton(true, animated:true)
    }

    
    func addLeftNavigationsBarButtons() {
        let back = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(navigationBackBtnAction))
        back.tintColor = .white
        self.navigationItem.leftBarButtonItems = [back]
    }
    
 
    @objc func navigationBackBtnAction() {
        if (navigationController != nil) {
            navigationController?.popViewController(animated: true)
        }
        else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
  
    
}
extension BaseVC : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navController = navigationController {
            if(navController.viewControllers.count > 1){
                return true
            }
        }
        return false
    }
}
