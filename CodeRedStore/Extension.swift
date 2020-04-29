//
//  Extension.swift
//  CodeRedStore
//
//  Created by denisok on 08/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    func showMessage(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .cancel) { (action) in
            
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
