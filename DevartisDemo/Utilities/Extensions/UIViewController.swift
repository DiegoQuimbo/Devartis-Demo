//
//  UIViewController.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgressHud(view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.1)
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        
    }
    
    func hideProgressHud(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
