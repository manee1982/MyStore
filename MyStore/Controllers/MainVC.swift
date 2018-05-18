//
//  ViewController.swift
//  MyStore
//
//  Created by Smart Visions on 3/27/18.
//  Copyright © 2018 Smart Visions. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var items: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= 2 {
            tableView.register(AfterTopRowsCell.self, forCellReuseIdentifier: "afterTopRowsCell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "afterTopRowsCell") as? AfterTopRowsCell {
                
                return cell
            } else {
                return AfterTopRowsCell()
            }
            
        } else {
            
            tableView.register(TopRowsCell.self, forCellReuseIdentifier: "topRowsCell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "topRowsCell") as? TopRowsCell {
                
                tableView.rowHeight = 150
                cell.count = indexPath.row
                
                if let items = items {
                  cell.setupViews(data: items[indexPath.row])
                }
                
                
                return cell
            } else {
                
                return TopRowsCell()
            }
        }
    }
    
    func getData() {
        let url = URL(string: "http://192.168.1.107/store/main.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("Error connecting to server \(error)")
                
            } else {
                
                if let response = response as? HTTPURLResponse {
                    
                    if response.statusCode == 200 {
                        
                        if let data = data {
                            do {
                                let json = try JSONDecoder().decode([Items].self, from: data)
                                print(json)
                                self.items = json
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                                
                            } catch let parsingError {
                                print("Error parsing json \(parsingError)")
                            }
                        }
                        
                    } else {
                        print("Error in response code...")
                    }
                    
                }
            }
        }.resume()
    }
}

