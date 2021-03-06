//
//  RestaurantsTableViewController.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/20.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {
    
    //Data Source
    var restaurantsArray: [[String:Any?]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPIdata(latitude: 40.697884, longitude: -73.993586)
        
//        tableView.delegate = self
//        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func getAPIdata(latitude : Double, longitude : Double){
        yelpAPI.getRestaurants(latitude: latitude, longitude: longitude){
            (restaurants) in guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return restaurantsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = restaurantsArray[indexPath.row]
        cell.nameLabel.text = restaurant["name"] as? String ?? ""


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
    
    /*
     Client ID
     DyiSA0yxVGN8zSRaYHoyMA

     API Key
     eT8Uqx2sMSBPt0sGoQ5m3ZnbMMLoKEDPpruVLpGgdWzr1a7D9dR051vB3ppqjkRM1BjtgikzWpm-Kw4vEEUiSDbbp0-Fc4M59QXyizD4Q9LsjNPFAAxaHmRcqKhgYnYx
     */

}
