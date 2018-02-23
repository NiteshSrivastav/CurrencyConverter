//
//  ViewController.swift
//  CountryCapitalApp
//
//  Created by Nitesh Srivastva on 08/02/18.
//  Copyright © 2018 Nitesh Srivastva. All rights reserved.
//

import UIKit

struct Country : Decodable{
       var name : String
    var capital : String
     var region : String
     var flag : String
}

class ViewController: UIViewController,UITableViewDataSource {
    
    
    var countries = [Country]()
    
    
    @IBOutlet weak var tblView: UITableView!
    
var jsonUrl = "https://restcountries.eu/rest/v2/all"
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        self.fetchData()
        tblView.reloadData()
       
    }
    //table View Data Source Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return countries.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CountryViewCell
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")

       
      //  cell.textLabel?.text = self.countries[indexPath.row].capital
        cell.namelbl.text = self.countries[indexPath.row].name
        cell.capitallbl.text = self.countries[indexPath.row].capital
        cell.regionlbl.text = self.countries[indexPath.row].region
        
        if countries[indexPath.row].flag == "" {
            cell.imgView.image = UIImage(named: "nit.jpg")
        } else {
            let urllist = "https://restcountries.eu/data/dza.svg"
            let imgURL = URL(string : urllist)
           // let imgURL = NSURL(string: countries[indexPath.row].flag)
            if let imageData = NSData(contentsOf: imgURL! as URL) {
                
                
                cell.imgView.image = UIImage(data: imageData as Data)
                
            }
            
        }
        
        return cell
        
    }

    func fetchData(){
        
        let url = URL(string: jsonUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
               self.countries = try JSONDecoder().decode([Country].self, from: data!)
                for eachCountry in self.countries{
                
                    self.countries.append(eachCountry)
                    
                }
                OperationQueue.main.addOperation({
                    self.tblView.reloadData()
                })
            }
            catch{
                print("Error")
            }
        }.resume()
        
    }


}

