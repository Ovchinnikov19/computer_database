//
//  ApiObjectCard.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 18.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import Foundation

struct objectCard {
    var idItem: Int?
    var nameItem: String?
    var introduced: String?
    var discounted: String?
    var imageUrl: String?
    
    var idCompany: Int?
    var nameCompany: String?
    
    var description: String?
}

class ApiObjectCard{
    
    var apiObjectCard = objectCard()
    
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
                    self.apiObjectCard.idItem = id
                }
                if let name = json["name"] as? String{
                    self.apiObjectCard.nameItem = name
                }
                if let introduced = json["introduced"]{
                    self.apiObjectCard.introduced = introduced as? String
                }
                if let discounted = json["discounted"]{
                    self.apiObjectCard.discounted = discounted as? String
                }
                if let imageUrl = json["imageUrl"]{
                    self.apiObjectCard.imageUrl = imageUrl as? String
                }
                
                if let description = json["description"] as? String{
                    self.apiObjectCard.description = description
                }
                
                if let company: [String: AnyObject] = json["company"] as? [String : AnyObject]{
                    if let idCompany = company["id"]{
                        self.apiObjectCard.idCompany = idCompany as? Int
                    }
                    if let nameCompany = company["name"]{
                        self.apiObjectCard.nameCompany = nameCompany as? String
                    }
                
                
                }
                
                
                
            } catch {
                print("error")
            }
            
        })
        task.resume()
    }
}
