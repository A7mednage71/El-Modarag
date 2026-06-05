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
            title: title ?? AppStrings.Alerts.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: AppStrings.Buttons.retry, style: .default) { _ in
            retryHandler()
        }
        
        let dismissAction = UIAlertAction(title: AppStrings.Buttons.ok, style: .cancel){_ in
            okayHandler()
        }
        
        alert.addAction(retryAction)
        alert.addAction(dismissAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showConfirmationAlert(
            on viewController: UIViewController,
            title: String?,
            message: String,
            okayTitle: String? = nil,
            cancelTitle: String? = nil,
            okayHandler: @escaping () -> Void,
            cancelHandler: (() -> Void)? = nil
        ) {
            
            let alert = UIAlertController(
                title: title ?? AppStrings.Alerts.defaultTitle,
                message: message,
                preferredStyle: .alert
            )
            
            let finalOkayTitle = okayTitle ?? AppStrings.Buttons.ok
            let finalCancelTitle = cancelTitle ?? AppStrings.Buttons.cancel
            
            let okayAction = UIAlertAction(title: finalOkayTitle, style: .default) { _ in
                okayHandler()
            }
            
            let cancelAction = UIAlertAction(title: finalCancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okayAction)
            
            viewController.present(alert, animated: true, completion: nil)
        }
    
    static func showLanguagePicker(on viewController: UIViewController, completion: @escaping (String) -> Void) {
        
        let alert = UIAlertController(
            title: AppStrings.Settings.LanguageAlert.title,
            message: AppStrings.Settings.LanguageAlert.message,
            preferredStyle: .actionSheet
        )
        
        let arabicAction = UIAlertAction(title: "العربية", style: .default) { _ in
            completion("ar")
        }
        
        let englishAction = UIAlertAction(title: "English", style: .default) { _ in
            completion("en")
        }
        
        let cancelAction = UIAlertAction(title: AppStrings.Buttons.cancel, style: .cancel, handler: nil)
        
        alert.addAction(arabicAction)
        alert.addAction(englishAction)
        alert.addAction(cancelAction)
                
        viewController.present(alert, animated: true, completion: nil)
    }
}
