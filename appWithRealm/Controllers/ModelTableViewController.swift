//
//  ModelTableViewController.swift
//  appWithRealm
//
//  Created by Burak Eryavuz on 11.07.2023.
//

import UIKit
import RealmSwift

class ModelTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    
    var models : Results<Model>?
    
    var parentBrand : Brand? {
        didSet{
            self.loadModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: - TABLEVIEW DATA SOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.modelTableCellName, for: indexPath)
        
        cell.textLabel?.text = (models?[indexPath.row].name)! + " " + (models?[indexPath.row].releaseDate)!
        
        return cell
    }
    

    //MARK: - ADD BUTTON METHOD
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFieldName = UITextField()
        var textFieldDate = UITextField()
        
        let alert = UIAlertController(title: "Add Model", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            do{
                try self.realm.write({
                    let newModel = Model()
                    newModel.name = textFieldName.text!
                    newModel.releaseDate = textFieldDate.text!
                    self.parentBrand?.models.append(newModel)
                })
                
                
            } catch {
                print("Error")
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { fieldName in
            textFieldName = fieldName
            textFieldName.placeholder = "Typing model name..."
        }
        
        alert.addTextField { fieldDate in
            textFieldDate = fieldDate
            textFieldDate.placeholder = "Typing model release date..."
        }
        
        alert.addAction(action)
        tableView.reloadData()
        present(alert, animated: true)
        tableView.reloadData()
    }
    
    

    
    func loadModel(){
        
        models = parentBrand?.models.sorted(byKeyPath: "name")
        tableView.reloadData()
        
    }
    
    
}
