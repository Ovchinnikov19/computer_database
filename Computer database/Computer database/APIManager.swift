//
//  APIManager.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 13.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import Foundation

struct ItemDatabase{
    var idItem: Int?
    var nameItem: String?
    var idCompany: Int?
    var nameCompany: String?
}

class APIManagerListItems {
    
    var arrayItems: [ItemDatabase] = []
    
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
                        self.arrayItems.append(itemDatabase)
                    }
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
}

func fetchObjectCard(idObjectCard: Int){
    var request = URLRequest(url: URL(string: "http://testwork.nsd.naumen.ru/rest/computers/\(idObjectCard)")!)
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        //print(response!)
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            //print(json)
            if let id = json["id"] as? Int{
                print("id = \(id)")
            }
            if let name = json["name"] as? String{
                print("name = \(name)")
            }
            if let introduced = json["introduced"]{
                print("introduced = \(introduced)")
            }
            if let discounted = json["discounted"]{
                print("discounted = \(discounted)")
            }
            if let imageUrl = json["imageUrl"]{
                print("imageUrl = \(imageUrl)")
            }
            
            if let company: [String: AnyObject] = json["company"] as? [String : AnyObject]{
                if let idCompany = company["id"]{
                    print("idCompany = \(idCompany)")
                }
                if let nameCompany = company["name"]{
                    print("nameCompany = \(nameCompany)")
                }
            }
            
            
            
        } catch {
            print("error")
        }
        
    })
    task.resume()
}



func fetchSimilarItems(id: Int){
    var request = URLRequest(url: URL(string: "http://testwork.nsd.naumen.ru/rest/computers/\(id)/similar")!)
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data!) as! Array<AnyObject>
                for json in jsonArray {
                    if let idItem = json["id"] as? Int{
                        print("id = \(idItem)")
                    }
                    if let nameItem = json["name"] as? String{
                        print("name = \(nameItem)")
                    }
                    print("")
                }
        } catch {
            print("error")
        }
    })
    task.resume()
}
