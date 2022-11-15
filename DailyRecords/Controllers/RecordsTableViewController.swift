//
//  RecordsTableViewController.swift
//  DailyRecords
//
//  Created by Sora on 31.10.2022.
//

import UIKit
import CoreData

class RecordsTableViewController: UITableViewController {
    
    let data = DataManipulation()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category? {
        didSet{
            data.loadData(context: context)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data.loadData(context: context)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toEditSegue {
            let destinationVC = segue.destination as! EditViewController
            let record = sender as? Record
            destinationVC.record = record
        }
    }
    
}

// MARK: - Table View DataSource

extension RecordsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManipulation.recordsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = DataManipulation.recordsList[indexPath.row]
        var text = ""
        if record.text == nil {
            text = ""
        } else if record.text!.count > 50 {
            text += "\(record.text!.prefix(49))..."
        } else {
            text = record.text!
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellRecordID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = record.title!.uppercased()
        content.secondaryText = text
        content.textProperties.color = UIColor(named: "Title 2")!
        content.secondaryTextProperties.color = UIColor(named: "Title 2")!
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "Cell")
        
        return cell
    }
}

//MARK: - Table View Delegate

extension RecordsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record  = DataManipulation.recordsList[indexPath.row]
        performSegue(withIdentifier: K.toEditSegue, sender: record)
    }
}
