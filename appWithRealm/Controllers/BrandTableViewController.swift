//
//  BrandTableViewController.swift
//  appWithRealm
//
//  Created by Burak Eryavuz on 11.07.2023.
//

import UIKit
import RealmSwift

class BrandTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let realm = try! Realm()
    var brands : Results<Brand>?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBrand()
        
    }
    
    
    //MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.brandTableCellName, for: indexPath)
        
        cell.textLabel?.text = brands?[indexPath.row].name
        
        return cell
    }
    
    //MARK: TABLEVIEW DELEGATE METHODS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.goToModelSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ModelTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC?.parentBrand = brands?[indexPath.row]
        }
    }
    
    

    //MARK: - ADD BUTTON METHOD
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Brand", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newBrand = Brand()
            newBrand.name = textField.text!
            self.saveBrand(object: newBrand)
            
            
        }
        
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Typing brand name..."
        }
        
        alert.addAction(action)
        
        tableView.reloadData()
        
        present(alert, animated: true)
        
        
    }
    
    
    //MARK: - MODEL MANIPULATION METHODS
    
    func saveBrand(object: Object) {
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            print("Error saving brand.")
        }
        
        tableView.reloadData()
    }
    
    func loadBrand(){
        self.brands = try! realm.objects(Brand.self)
        tableView.reloadData()
    }
    

}
