//
//  Alert.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

struct Alert {
    static func present(title: String?, message: String, actions: Alert.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension Alert {
    enum Action {
        case okay(handler: (() -> Void)?)
        case close
        
        // Returns the title of our action button
        private var title: String {
            switch self {
            case .okay:
                return Constants.Texts.alertOkTitle
            case .close:
                return Constants.Texts.alertCancelTitle
            }
        }
        
        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .okay(let handler):
                return handler
            case .close:
                return nil
            }
        }
        
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}

