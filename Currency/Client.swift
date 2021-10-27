//
//  Client.swift
//  Currency
//
//  Created by Wuz Good on 27.10.2021.
//

import Foundation
import UIKit

struct Client {
    
    private let privatBankAPI = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    private let nationalBankAPI = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"

    
    func getData(from bank: String, completion: @escaping (_ success: Any)->(Void)) {
        var string: String?
        
        switch bank {
        case "privat":
            string = privatBankAPI
            
        case "national":
            string = nationalBankAPI
            
        default:
            return
        }
        
        guard let bankURL = URL(string: string!) else { return }
        
        let request = URLRequest(url: bankURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if data != nil {
                do {
                    
                    switch bank {
                    case "privat":
                        let pbData = try JSONDecoder().decode(PB.self, from: data!)
                        completion(pbData)
                        
                    case "national":
                        let nbuData = try JSONDecoder().decode(NBU.self, from: data!)
                        completion(nbuData)

                    default:
                        return
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}


