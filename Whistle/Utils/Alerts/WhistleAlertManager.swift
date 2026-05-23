//
//  WhistleAlertManager.swift
//  Whistle
//
//  Created by Ahmed Nageh on 24/05/2026.
//

import Foundation
import UIKit

class WhistleAlertManager {
    
    static func showErrorAlert(on viewController: UIViewController,title: String? , message: String,okayHandler: @escaping () -> Void , retryHandler: @escaping () -> Void ) {
        
        let alert = UIAlertController(
            title: title ?? "Connection Error",
            message: message,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            retryHandler()
        }
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel){_ in
            okayHandler()
        }
        
        alert.addAction(retryAction)
        alert.addAction(dismissAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
