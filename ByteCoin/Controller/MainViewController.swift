//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        coinManager.coinDelegate = self
        
        let currentSelectedRow = currencyPicker.selectedRow(inComponent: 0)
        coinManager.getCoinData(currencyIndex: currentSelectedRow)
        
    }
    
}

//MARK: --UIPickerViewDelegate |  UIPickerViewDataSource
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinData(currencyIndex: row)
    }
}

//MARK: --CoinDelegate
extension MainViewController: CoinDelegate{
    func didGetCoinData(latestPrice: Double) {
        DispatchQueue.main.async {
            let currentSelectedRow = self.currencyPicker.selectedRow(inComponent: 0)
            self.currencyLabel.text = self.coinManager.currencyArray[currentSelectedRow]
            self.bitcoinLabel.text = String(format: "%.2f", latestPrice)
        }
    }
    
    func didGetError(_ error: Error) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Error", message: "\(error.localizedDescription) \n Please send this error to developer.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default))
            self.present(ac, animated: true)
        }
    }
    
}
