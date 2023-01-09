//
//  UIDevice+Jailbroken.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    func checkisDeviceJailBrocken() -> Bool {
        if UIDevice.current.isSimulator {
            return false // This should be true for real testing.
        }
        return false
    }
}
