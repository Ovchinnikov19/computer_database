//
//  APIManager.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 13.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import Foundation

class APIManager{
    
    
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
            if let id = json["id"]{
                print("id = \(id)")
            }
            if let name = json["name"] {
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

