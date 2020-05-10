//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let apiKey = "NWVkZGFlNWVjODZjNGFlZGI4OTM3MDBmMTUzMzdiZTc"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinData(){
        let urlString = "\(baseURL)\(currencyArray[2])"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)

            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "x-ba-key")
            
            let task = session.dataTask(with: request) { (data, response, error) in

                if let validData = data{
                    print(String(data: data!, encoding: String.Encoding.utf8)!)
                    self.parseJSON(coinData: validData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(coinData :Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            print(decodedData)
        }catch{
            print(error)
        }
    }
}
