//
//  BaseVM.swift
//  WanaSell
//
//  Created by  on 14/04/2020.
//  Copyright © 2020 iwament. All rights reserved.
//

import Foundation
protocol BaseModeling:class {
    
    func addObservers()
    func removeObservers()
    
    typealias showDialogAlias = (String)->()
    var showLogoutMessage:showDialogAlias?{get set}
    
    typealias showErrorAlias = (String) -> ()
    var showError:showErrorAlias? {get set}
    
    typealias removeDialogAlias = ()->()
    var removeTransparentVC : removeDialogAlias? {get set}
    
    typealias restartAppAlias = () -> ()
    var restartAppFromSplash : restartAppAlias?{get set}
    
}

class BaseVM: BaseModeling {
    var removeTransparentVC: BaseModeling.removeDialogAlias?
    var removeAssignmentDialog: BaseModeling.removeDialogAlias?
    var showLogoutMessage: BaseModeling.showDialogAlias?
    var showError: BaseModeling.showErrorAlias?
    var restartAppFromSplash: BaseModeling.restartAppAlias?

    
    
    func addObservers() {
        removeObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(showLogOutMessage), name: .sessionOut , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showServerErrorMessage), name: .internalServerError , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPageNotFoundMessage), name: .pageNotfound , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAPIErrorMessage(notification:)), name: .apiError , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(serverNotFoundMessage), name: .serverNotfound , object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(restartApp), name: .splash , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showRequestTimeOut), name: .requestTimeOut , object: nil)
    }
    
    func removeObservers() {
        
        
        
        NotificationCenter.default.removeObserver(self, name: .sessionOut , object: nil)
        NotificationCenter.default.removeObserver(self, name: .internalServerError , object: nil)
        NotificationCenter.default.removeObserver(self, name: .splash , object: nil)
        NotificationCenter.default.removeObserver(self, name: .pageNotfound , object: nil)
        NotificationCenter.default.removeObserver(self, name: .apiError , object: nil)
        NotificationCenter.default.removeObserver(self, name: .serverNotfound , object: nil)
        
        
        NotificationCenter.default.removeObserver(self, name: .requestTimeOut , object: nil)
    }

    @objc func restartApp() {
        restartAppFromSplash?()
    }
    
    
    @objc func showRequestTimeOut() {
        
        showError?("Request Time Out")
    }
    
    @objc func showLogOutMessage() {
        
        showLogoutMessage?("Your session has been expired, Please Log in again.")
    }
    
    @objc func serverNotFoundMessage() {
        
        showError?("Server Not Found")
    }
    
    @objc func showPageNotFoundMessage() {
        
        showError?("Page not found")
    }
    
    @objc func showAPIErrorMessage(notification: Notification) {
        
        
//        guard let userInfo = notification.userInfo, let requestId = userInfo["requestId"] as? String else {
//            showError?("What happened 🌝? There seems to be a slight problem, we're working on fixing it.")
//            return
//        }
        
        showError?("What happened 🌝? There seems to be a slight problem, we're working on fixing it.")
    }
    
    @objc func showServerErrorMessage() {
        
        showError?("What happened 🌝? There seems to be a slight problem, we're working on fixing it.")
    }
    
    
}
