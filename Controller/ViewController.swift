//
//  ViewController.swift
//  WeatherAppTwo
//
//  Created by Duale on 7/10/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController  , UIPickerViewDelegate , UIPickerViewDataSource   {
    
    //    let result = formatter.String(from: Date)
    
    //    var datetime = DateAndTime(date: Date() , formatter: DateFormatter())
    //
    //    var dateandtime : String = "";
    
    
    //    formatter.dateFormat = "dd.MM.yyyy"
    
    //    let result = formatter.String(from: date)
    //    print(result)
    let baseURL = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="
    let dataSrc = "&apikey=QO7P95AT6A0S5956"
    let StockArray = ["MSFT", "FCEL","INTC","AAPL","AMRN","EBAY","AMZN","NFLX","CSCO","CMCSA","NVDA","SBUX","JBLU","QCOM   ","URBN","FISV","HBAN","SYMC","AMRN","FAST"]
    var finalURL = ""
    
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLable: UILabel!
    
    @IBOutlet weak var imageViewLabel: UIImageView!
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    let date = Date()
    let formatter = DateFormatter()
    var result = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        circulateStock ()
        self.formatter.dateFormat = "yyyy-MM-dd"
        result = formatter.string(from: date)
        populatePrice()
        //        dateandtime = datetime.getDate()
        fitTextIntoLabel()
    }
    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StockArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StockArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + StockArray[row] + dataSrc
        print(finalURL)
        getStockDetails(url: finalURL)
        //        print("===============")
        //        print(result)
        switch(row) {
        case 0:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 1:  imageViewLabel.image = UIImage(named: StockArray[row])
        case 2:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 3:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 4:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 5:  imageViewLabel.image = UIImage(named: StockArray[row])
        case 6:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 7:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 8:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 9:  imageViewLabel.image = UIImage(named: StockArray[row])
        case 10:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 11:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 12:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 13:  imageViewLabel.image = UIImage(named: StockArray[row])
        case 14:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 15:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 16:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 17:  imageViewLabel.image = UIImage(named: StockArray[row])
        case 18:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
        case 19:  imageViewLabel.image = UIImage(named: StockArray[row])
        break;
            
        default:
            imageViewLabel.image = UIImage(named: "background")
            break;
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str : String = StockArray[row]
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow])
    }
    
    
    
    
    //
    //    //MARK: - Networking
    
    
    func getStockDetails (url: String ) {
        Alamofire.request(url , method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Succees")
                let stockJSON : JSON = JSON(response.result.value!)
                //                print(stockJSON)
                //                if stockJSON["Time Series (Daily)"].string != nil {
                //                  print(stockJSON["Time Series (Daily)"])
                //                }
                self.updateStockData(json: stockJSON)
            } else {
                print("Not found")
            }
        }
    }
    //
    //
    //
    //
    //
    //    //MARK: - JSON Parsing
    //    /***************************************************************/
    
    
    
    func updateStockData (json: JSON) {
        //        print("********************")
        //        print(json)
        if let times = json["Time Series (Daily)"].dictionary  {
            //
            for (key , value) in times {
                //                if (String(key) == result) {
                //                    print(value)
                self.bitcoinPriceLabel.text = "Open:  " +  "$ " + value["1. open"].string!
                self.highLable.text = "High: " +  "$ " +  value["2. high"].string!
                self.lowLabel.text = "Low: " +   "$ " + value["3. low"].string!
                self.closeLabel.text = "Close: " + "$ " + value["4. close"].string!
                self.volumeLabel.text = "Volume: " + "$ " + value["5. volume"].string!
                break;
            }
            
            //
        } else {
            self.bitcoinPriceLabel.text = "Unavailable"
            self.lowLabel.text = "Unavailable"
            self.highLable.text = "Unavailable"
            print(result + "=========result")
        }
        
    }
    
    func circulateStock ()  {
        imageViewLabel.layer.borderWidth = 1
        imageViewLabel.layer.masksToBounds = false
        //        imageViewLabel.layer.borderColor = UIColor.black.cgColor
        imageViewLabel.layer.cornerRadius = imageViewLabel.frame.height/2
        imageViewLabel.clipsToBounds = true
        
    }
    
    func populatePrice () {
        self.bitcoinPriceLabel.textColor = UIColor.yellow
        self.lowLabel.textColor = UIColor.red
        self.highLable.textColor = UIColor.green
    }
    
    func fitTextIntoLabel ()  {
        bitcoinPriceLabel.sizeToFit()
        bitcoinPriceLabel.adjustsFontSizeToFitWidth = true
        lowLabel.sizeToFit()
        lowLabel.adjustsFontSizeToFitWidth = true
        highLable.sizeToFit()
        highLable.adjustsFontSizeToFitWidth = true
        
    }
    
    
    
    
}

