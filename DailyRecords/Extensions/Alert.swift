//
//  Alert.swift
//  DailyRecords
//
//  Created by Sora on 8.11.2022.
//

import Foundation
import UIKit

class Alert {
    
    func addAlert(message: String, actionTitle: String ) -> UIAlertController {
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel)
        
        alert.addAction(alertAction)
        return alert
    }
}
