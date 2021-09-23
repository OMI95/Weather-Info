//
//  CitiesViewController.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var cities = [City]()
    var filteredCities = [City]()
    var isFiltered: Bool! = false
    
    var didSelectCity: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(btnCancelTapped(_:)))

        
    }
    
    @objc func btnCancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getData()
    }
}

extension CitiesViewController {
    private func getData() {
        guard let data = AppConstants.shared.readLocalFile(forName: "city.list") else {
            return
        }
        
        do {
            let jsonObject = try JSONDecoder().decode([City].self, from: data)
            self.cities = jsonObject
            self.tableView.reloadData()
        } catch {
            print("No Data")
        }
        
    }
}

extension CitiesViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "City Name"
        cell.detailTextLabel?.text = self.cities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.cities[indexPath.row].id
        self.didSelectCity?(String(id))
    }
}

extension CitiesViewController : UITextFieldDelegate {
    
}
