//
//  ItemCardViewController.swift
//  Computer database
//
//  Created by Eduard Ovchinnikov on 18.05.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import UIKit

class ItemCardViewController: UIViewController {
    
    var idItemCard = 0
    
    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var dateIntroduced: UILabel!
    @IBOutlet weak var textDiscription: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    
    @IBOutlet weak var similaryObject1: UILabel!
    @IBOutlet weak var similaryObject2: UILabel!
    @IBOutlet weak var similaryObject3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemCard = ApiObjectCard()
        itemCard.fetchObjectCard(idObjectCard: idItemCard)
        sleep(1)
        let cardObject = itemCard.apiObjectCard
        nameCompany.text = cardObject.nameCompany
        dateIntroduced.text = cardObject.introduced
        textDiscription.text = cardObject.description
        
        if let url = NSURL(string: cardObject.imageUrl!){
            let data = NSData(contentsOf: url as URL)
            imageItem.image = UIImage(data:data! as Data)
            }
        }
        // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
