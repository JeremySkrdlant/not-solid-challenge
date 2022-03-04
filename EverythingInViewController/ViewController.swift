//
//  ViewController.swift
//  EverythingInViewController
//
//  Created by Jeremy Skrdlant on 3/3/22.
//

import UIKit

class ViewController: UITableViewController {

    private enum MyErrors:Error, LocalizedError{
        case noLoadPList
        case dataChangeError
    }
    
    private struct CryptoCoin:Codable{
        var name:String
        var price:Double
    }
    
    private var coins:[CryptoCoin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load in coins from the plist
        do{
            guard let url = Bundle.main.url(forResource: "CryptoPrices", withExtension: "plist")
            else {
                throw MyErrors.noLoadPList
            }
            
             let data = try Data(contentsOf: url)
             let propertyListDecoder = PropertyListDecoder()
            coins = try propertyListDecoder.decode([CryptoCoin].self, from: data)
            
        }catch{
            print(error.localizedDescription)
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell")!
        
        let currentCoin = coins[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = currentCoin.name
        content.secondaryText = currentCoin.price.formatted(.currency(code: "usd"))
        cell.contentConfiguration = content
        
        return cell
    }
    
}

