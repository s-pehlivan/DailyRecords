//
//  ViewController.swift
//  DailyRecords
//
//  Created by Sora on 31.10.2022.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var record: Record?
    var currentIndex: Int?
    let data = DataManipulation()
    let alert = Alert()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let safeRecord = record {
            titleTextField.text = safeRecord.title
            textTextView.text = safeRecord.text
            let date = safeRecord.date
            dateLabel.text = "\(formatDate(date: date ?? Date()))  -  \(safeRecord.text?.count ?? 0) char"
            
            if let index = DataManipulation.recordsList.firstIndex(where: {$0 === safeRecord}) {
                currentIndex = index
                print(currentIndex!)
            }
        } else {
            deleteButton.title = ""
            dateLabel.text = "\(formatDate())  -  0 Char"
        }
        
    }

    @IBAction func donePressed(_ sender: Any) {
                
        if titleTextField.text != "" {
            
            if currentIndex == nil {
                let record = Record(context: context)
                record.title = titleTextField.text
                record.text = textTextView.text
                record.date = Date()
                
                data.saveData(context: context)
            } else if currentIndex != nil {
                DataManipulation.recordsList[currentIndex!].title = titleTextField.text
                DataManipulation.recordsList[currentIndex!].text = textTextView.text
                DataManipulation.recordsList[currentIndex!].date = Date()
                
                data.saveData(context: context)
            }
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            let alert = alert.addAlert(message: "Please add a title.", actionTitle: "OK")
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if deleteButton.title != "" && currentIndex != nil {
            data.deleteData(at: currentIndex!, context: context)
            DataManipulation.recordsList.remove(at: currentIndex!)
            data.saveData(context: context)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

//MARK: - Date Formatter

extension EditViewController {
    func formatDate(date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy   HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

