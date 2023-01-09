//
//  BaseViewController.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Put all stuffs which are common to all other ViewControllers
    func setNavigationAppearance(title: String) {
        self.navigationItem.title = title
    }
}

