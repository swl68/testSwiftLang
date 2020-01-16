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
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
