//
//  ViewController.swift
//  DailyRecords
//
//  Created by Sora on 31.10.2022.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var record: Record?
    var currentArrayIndex: Int?
    let data = DataManipulation()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if record == nil {
            deleteButton.title = ""
        }
        
        if let safeRecord = record {
            if let index = DataManipulation.recordsList.firstIndex(where: {$0 === safeRecord}) {
                currentArrayIndex = index
            }
        }
    }

    @IBAction func donePressed(_ sender: Any) {
        if let title = titleTextField.text {
            let record = Record(context: context)
            record.title = title
            record.text = textTextView.text
            record.date = Date()
            
            if currentArrayIndex != nil {
                DataManipulation.recordsList[currentArrayIndex!] = record
            } else {
                DataManipulation.recordsList.append(record)
            }
            
            data.saveData(context: context)
            
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            //TODO: Show Alert to tell the user to fill the title area.
        }
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if deleteButton.title != "" && currentArrayIndex != nil {
            DataManipulation.recordsList.remove(at: currentArrayIndex!)
            data.saveData(context: context)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

