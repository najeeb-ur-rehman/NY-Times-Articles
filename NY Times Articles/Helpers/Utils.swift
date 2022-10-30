//
//  Utils.swift
//  NY Times Articles
//
//  Created by Najeeb on 29/10/2022.
//

import UIKit

class Utils {
    
    static func showOkAlert(title: String = "", message: String, viewController: UIViewController) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        showActionAlert(title: title, message: message, viewController: viewController, alertActions: [okAction])
    }
    
    static func showActionAlert(title: String = "", message: String, viewController: UIViewController, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Unable to get API Key")
        }
        return key
    }
    
    static var baseUrl: URL {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("Unable to get Base URL")
        }
        return url
    }
}

