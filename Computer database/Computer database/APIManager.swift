//
//  APIManager.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 13.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import Foundation


func fetch(){
    var request = URLRequest(url: URL(string: "http://testwork.nsd.naumen.ru/rest/computers/14")!)
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        //print(response!)
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            //print(json)
            let id = json["id"]
            let name = json["name"]
            let company: [String: AnyObject] = json["company"] as! [String : AnyObject]
            let idCompany = company["id"]
            let nameCompany = company["name"]
            print("""
                id= \(id!) name = \(name!)
                company: id= \(idCompany!) name = \(nameCompany!)
                """)
            
        } catch {
            print("error")
        }
        
    })
    task.resume()
}
