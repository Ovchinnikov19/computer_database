//
//  TableViewController.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 14.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableArrayList = ApiListItems()
    var valueArrayList: [ItemDatabase] = []
    var indexSegue: Int = 0
    var pageList: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchListItems(page: pageList)
        sleep(1)
    }
    
    func fetchListItems(page: Int){
        var request = URLRequest(url: URL(string: "http://testwork.nsd.naumen.ru/rest/computers?p=\(page)")!)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                if let items: [AnyObject] = jsonArray["items"] as? [AnyObject]{
                    for json in items {
                        var itemDatabase = ItemDatabase()
                        if let idItem = json["id"] as? Int{
                            itemDatabase.idItem = idItem
                            
                        }
                        if let nameItem = json["name"] as? String{
                            itemDatabase.nameItem = nameItem
                        }
                        
                        if let company: [String: AnyObject] = json["company"] as? [String : AnyObject]{
                            if let idCompany = company["id"] as? Int{
                                itemDatabase.idCompany = idCompany
                            }
                            if let nameCompany = company["name"] as? String{
                                itemDatabase.nameCompany = nameCompany
                            }
                        }
                        self.valueArrayList.append(itemDatabase)
                    }
                }
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return valueArrayList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTable", for: indexPath)
        
        cell.textLabel?.text = valueArrayList[indexPath.row].nameItem
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editVC = segue.destination as? ItemCardViewController{
            let indexPathCell = tableView.indexPath(for: sender as! UITableViewCell)
            editVC.idItemCard = valueArrayList[(indexPathCell?.row)!].idItem!
            title = valueArrayList[(indexPathCell?.row)!].nameItem!
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
