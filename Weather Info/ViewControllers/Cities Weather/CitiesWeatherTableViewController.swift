//
//  CitiesWeatherTableViewController.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import UIKit

class CitiesWeatherTableViewController: UITableViewController {
    
    let weatherVM = WeatherViewModel.shared
    var citiesWeather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped(_:)))
        
        self.getWeather()
    }
    
    private func getWeather() {
        weatherVM.getWeathers()
        weatherVM.updateLoadingStatus = {
            if self.weatherVM.isLoading {
                self.showIndicator(withTitle: "", and: "Please wait...")
            }
            else {
                self.hideIndicator()
            }
        }
        
        self.weatherVM.didFinishCalling = {
            if let dt = self.weatherVM.citiesWeatherList {
                self.citiesWeather = dt
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func btnAddTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "cities", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cities" {
            if let nav = segue.destination as? UINavigationController {
                if let dest = nav.topViewController as? CitiesViewController {
                    dest.didSelectCity = { id in
                        dest.dismiss(animated: true) {
                            AppConstants.shared.updateCityIds(id: id)
                            self.getWeather()
                        }
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = citiesWeather?.list.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitiesTableViewCell
        
        if let dt = self.citiesWeather?.list[indexPath.row] {
            cell.lblCity.text = dt.name
            cell.lblTemp.text = String(dt.main.temp)
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
