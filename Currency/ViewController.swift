//
//  ViewController.swift
//  Currency
//
//  Created by Wuz Good on 27.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var pbTableView: UITableView!
    @IBOutlet var nbuTableView: UITableView!
    
    var privatBank = [PrivatBank]()
    var nationalBank = [NationalBank]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
        
    }
    
    private func setup() {
        pbTableView.delegate = self
        pbTableView.dataSource = self
        nbuTableView.delegate = self
        nbuTableView.dataSource = self
    }
    
    private func fetchData() {
        let client = Client()
        
        client.getData(from: "privat") { data in
            guard let data = data as? [PrivatBank] else { return }
            self.privatBank = data
            
            DispatchQueue.main.async {
                self.pbTableView.reloadData()
            }
        }
        
        client.getData(from: "national") { data in
            guard let data = data as? [NationalBank] else { return }
            self.nationalBank = data
            
            DispatchQueue.main.async {
                self.nbuTableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case pbTableView:
            return privatBank.count
        case nbuTableView:
            return nationalBank.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case pbTableView:
            
            if indexPath.row == 0 {
                let cell = pbTableView.dequeueReusableCell(withIdentifier: "PrivatTableViewCell", for: indexPath) as! PrivatTableViewCell
                cell.currencyLabel.text = "Валюта"
                cell.buyLabel.text = "Покупка"
                cell.saleLabel.text = "Продажа"
                
                return cell
                
            } else {
                let cell = pbTableView.dequeueReusableCell(withIdentifier: "PrivatTableViewCell", for: indexPath) as! PrivatTableViewCell
                
                if let buyValue = Double(privatBank[indexPath.row - 1].buy) {
                    cell.buyLabel.text = String(format: "%.3f", buyValue)
                }
                
                if let saleLabel = Double(privatBank[indexPath.row - 1].sale) {
                    cell.saleLabel.text = String(format: "%.3f", saleLabel)
                }
                
                cell.currencyLabel.text = privatBank[indexPath.row - 1].ccy
                
                return cell
            }
        case nbuTableView:
            let cell = nbuTableView.dequeueReusableCell(withIdentifier: "NationalTableViewCell", for: indexPath) as! NationalTableViewCell
            cell.currencyLabel.text = nationalBank[indexPath.row].txt
            cell.currencyCodeLabel.text = nationalBank[indexPath.row].cc
            cell.rateLabel.text = String(format: "%.3f", nationalBank[indexPath.row].rate)
            cell.rateLabel.sizeToFit()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == pbTableView {
            return "ПриватБанк"
        } else {
            return "НБУ"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView == pbTableView {
            if indexPath.row == 0 {
                return nil
            }
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case pbTableView:
            matchCurrency(tableView: tableView, indexPath: indexPath)
            print("table: \(tableView), cell: \(indexPath.row)")
        case nbuTableView:
            matchCurrency(tableView: tableView, indexPath: indexPath)
            print("table: \(tableView), cell: \(indexPath.row)")
            
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == nbuTableView {
            return 60
        } else {
            return 44
        }
    }
    
    fileprivate func matchNationalBank(_ indexPath: IndexPath) {
        var tappedValue = nationalBank[indexPath.row].cc
        
        if tappedValue == "RUB" {
            tappedValue = "RUR"
        }
        
        for (index, currency) in privatBank.enumerated() {
            if currency.ccy == tappedValue {
                pbTableView.selectRow(at: IndexPath(row: index + 1, section: 0), animated: true, scrollPosition: .middle)
            }
        }
    }
    
    fileprivate func matchPrivatBank(_ indexPath: IndexPath) {
        var tappedValue = privatBank[indexPath.row - 1].ccy
        
        if tappedValue == "RUR" {
            tappedValue = "RUB"
        }
        
        for (index, currency) in nationalBank.enumerated() {
            if currency.cc == tappedValue {
                nbuTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
            }
        }
    }
    
    private func matchCurrency(tableView: UITableView, indexPath: IndexPath) {
        
        switch tableView {
        case pbTableView:
            matchPrivatBank(indexPath)
            
        case nbuTableView:
            matchNationalBank(indexPath)
            
        default:
            return
        }
    }
}

