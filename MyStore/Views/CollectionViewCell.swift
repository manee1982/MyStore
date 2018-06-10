//
//  CollectionViewCell.swift
//  MyStore
//
//  Created by Smart Visions on 5/24/18.
//  Copyright © 2018 Smart Visions. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    let imageViewer: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    func setupViews(data: Items) {
        
        self.addSubview(label)
        label.text = data.item_name
        label.textAlignment = .center
        label.font = UIFont(name: "HacenJordan", size: 17)
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        
        self.addSubview(imageViewer)
        imageViewer.contentMode = .scaleAspectFill
        imageViewer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageViewer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        getImageFromUrl(imageUrl: data.item_image)
        
    }
    
    func getImageFromUrl(imageUrl: String) {
        let url = URL(string: "http://192.168.1.104/store/" + imageUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("Error connecting to server \(error)")
                
            } else {
                
                if let response = response as? HTTPURLResponse {
                    
                    if response.statusCode == 200 {
                        
                        if let data = data {
                            DispatchQueue.main.async {
                                self.imageViewer.image = UIImage(data: data)
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
