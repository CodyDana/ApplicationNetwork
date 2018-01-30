//
//  TableViewController.swift
//  Application Network
//
//  Created by Cody Dana on 1/19/18.
//  Copyright © 2018 Cody Dana. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UIViewController , UITableViewDataSource, UISearchBarDelegate{
    
    // Array of type Coins
    var fetchedCoin = [Coins]()
    
    @IBOutlet weak var coinTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.parse()
        self.searchBar()
    }
    
    func parse() {
        coinTableView.dataSource = self
        
        let jsonUrlString = "https://api.coinmarketcap.com/v1/ticker/?start=0&limit=10"
        
        // Making sure this is a valid URL
        guard let url = URL(string:jsonUrlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            // This solved the problem of the list not coming up immediately.
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                    //else { print("JSON error"); return }
                    
                    //print(myJSON)
                    for eachFetchedCoin in myJSON
                    {
                        let eachItem = eachFetchedCoin as! [String : Any]
                        let id = eachItem["id"] as! String
                        let name = eachItem["name"] as! String
                        let symbol = eachItem["symbol"] as! String
                        let rank = eachItem["rank"] as! String
                        let price_usd = eachItem["price_usd"] as! String
                        let price_btc = eachItem["price_btc"] as! String
                        let twentyFourHr_volume_usd = eachItem["24h_volume_usd"] as! String
                        let market_cap_usd = eachItem["market_cap_usd"] as! String
                        let available_supply = eachItem["available_supply"] as! String
                        let total_supply = eachItem["total_supply"] as! String
                        
                        // Sometimes the max_supply isn't available for a coin
                        let max_supply = eachItem["max_supply"] as? String ?? "---"
                        let percent_change_1h = eachItem["percent_change_1h"] as! String
                        let percent_change_24h = eachItem["percent_change_24h"] as! String
                        let percent_change_7d = eachItem["percent_change_7d"] as! String
                        let last_updated = eachItem["last_updated"] as! String
                        
                        self.fetchedCoin.append(Coins(id: id, name: name, symbol: symbol, rank: rank, price_usd: price_usd, price_btc: price_btc, twentyFourHr_volume_usd: twentyFourHr_volume_usd, market_cap_usd: market_cap_usd, available_supply: available_supply, total_supply: total_supply, max_supply: max_supply, percent_change_1h: percent_change_1h, percent_change_24h: percent_change_24h, percent_change_7d: percent_change_7d, last_updated: last_updated))
                    }
                    
                    // Reload data
                    self.coinTableView.reloadData()
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }
            
            }.resume()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func searchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.scopeButtonTitles = ["Name", "Symbol"]
        self.coinTableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            parse()
        }
        else {
            if searchBar.selectedScopeButtonIndex == 0 {
                fetchedCoin = fetchedCoin.filter({ (name) -> Bool in
                    return name.name.lowercased().contains(searchText.lowercased())
                })
            }
            else {
                fetchedCoin = fetchedCoin.filter({ (name) -> Bool in
                    return name.symbol.lowercased().contains(searchText.lowercased())
                })
            }
        }
        
        self.coinTableView.reloadData()
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCoin.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = fetchedCoin[indexPath.row].name
        cell?.detailTextLabel?.text = fetchedCoin[indexPath.row].symbol
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class Coins
    {
        
        var id: String
        var name: String
        var symbol: String
        var rank: String
        var price_usd: String
        var price_btc: String
        var twentyFourHr_volume_usd: String
        var market_cap_usd: String
        var available_supply: String
        var total_supply: String
        var max_supply: String
        var percent_change_1h: String
        var percent_change_24h: String
        var percent_change_7d: String
        var last_updated: String
        
        init(id: String, name: String, symbol: String, rank: String, price_usd: String, price_btc: String, twentyFourHr_volume_usd: String, market_cap_usd: String, available_supply: String, total_supply: String, max_supply: String, percent_change_1h: String, percent_change_24h: String, percent_change_7d: String, last_updated: String) {
            self.id = id
            self.name = name
            self.symbol = symbol
            self.rank = rank
            self.price_usd = price_usd
            self.price_btc = price_btc
            self.twentyFourHr_volume_usd = twentyFourHr_volume_usd
            self.market_cap_usd = market_cap_usd
            self.available_supply = available_supply
            self.total_supply = total_supply
            self.max_supply = max_supply
            self.percent_change_1h = percent_change_1h
            self.percent_change_24h = percent_change_24h
            self.percent_change_7d = percent_change_7d
            self.last_updated = last_updated
        }
        
        
        //        struct coinDetails {
        //            let id: String;
        //            let name: String;
        //            let symbol: String;
        //            let rank: Int;
        //            let price_usd: Int;
        //            let price_btc: Int;
        //            let twentyFourHr_volume_usd: Int;
        //            let market_cap_usd: Int;
        //            let available_supply: Int;
        //            let total_supply: Int;
        //            let max_supply: Int;
        //            let percent_change_1h: Int;
        //            let percent_change_24h: Int;
        //            let percent_change_7d: Int;
        //            let last_updated: Int;
        //
        //            init(json: [String: Any]) {
        //                id = json["id"] as? String ?? ""
        //                name = json["name"] as? String ?? ""
        //                symbol = json["symbol"] as? String ?? ""
        //                rank = json["rank"] as? Int ?? -1
        //                price_usd = json["price_usd"] as? Int ?? -1
        //                price_btc = json["price_btc"] as? Int ?? -1
        //                twentyFourHr_volume_usd = json["twentyFourHr_volume_usd"] as? Int ?? -1
        //                market_cap_usd = json["market_cap_usd"] as? Int ?? -1
        //                available_supply = json["available_supply"] as? Int ?? -1
        //                total_supply = json["total_supply"] as? Int ?? -1
        //                max_supply = json["max_supply"] as? Int ?? -1
        //                percent_change_1h = json["percent_change_1h"] as? Int ?? -1
        //                percent_change_24h = json["percent_change_24h"] as? Int ?? -1
        //                percent_change_7d = json["percent_change_7d"] as? Int ?? -1
        //                last_updated = json["last_updated"] as? Int ?? -1
        //            }
        //        }
    }
}

