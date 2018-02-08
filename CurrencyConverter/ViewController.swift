//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nitesh Srivastva on 08/02/18.
//  Copyright © 2018 Nitesh Srivastva. All rights reserved.
//

import UIKit

struct Currency : Decodable {
    let base : String
    let date : String
    let rates : [String: Double]
}

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var curTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var usd : Currency?
    var baseRate = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        tableView.allowsSelection = false
//        tableView.showsVerticalScrollIndicator = false
        self.fetchData()
       
    }

    @IBAction func convertBtnPressed(_ sender: UIButton) {
        if  let isGetString = curTF.text{
            if let isDouble = Double(isGetString){
                baseRate = isDouble
                fetchData()
            }
            
        }
        
        
    }
    //table View Data Source Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currencyFetched = usd {
            return currencyFetched.rates.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let currencyFetched = usd {
            cell.textLabel?.text = Array(currencyFetched.rates.keys)[indexPath.row]
            let selectedRate = baseRate * Array(currencyFetched.rates.values)[indexPath.row]
            cell.detailTextLabel?.text = "\(selectedRate)"
            return cell
        }
        return UITableViewCell()
    }
    
    func fetchData(){
        let url = URL(string : "https://api.fixer.io/latest?base=USD")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if url != nil{
                do{
                    self.usd = try JSONDecoder().decode(Currency.self,from : data!)
                }
                catch{
                    print("parse Error")
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                   // print(self.usd?.base)
                }
                
            }
            else {
                print("Error")
            }
        }.resume()
    }
    

}

