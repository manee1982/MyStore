//
//  TopRowsCell.swift
//  MyStore
//
//  Created by Smart Visions on 5/16/18.
//  Copyright © 2018 Smart Visions. All rights reserved.
//

import UIKit

class TopRowsCell: UITableViewCell {
    
    var count = 0

    let title: UILabel = {
        let tit = UILabel()
        tit.translatesAutoresizingMaskIntoConstraints = false
        tit.textAlignment = .center
        return tit
    }()
    
    let imageViewer: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let category: UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        return cat
    }()
    
    func setupViews(data: Items) {
        let container = UIView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        if count == 0 {
            title.textColor = #colorLiteral(red: 0.862745098, green: 0.662745098, blue: 0.4549019608, alpha: 1)
            container.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.8705882353, blue: 0.8, alpha: 1)
            
        } else {
            title.textColor = #colorLiteral(red: 0.8745098039, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
            container.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.8745098039, blue: 0.8784313725, alpha: 1)
        }
        
        
        container.addSubview(title)
        title.text = data.item_name
        title.font = UIFont(name: "HacenJordan", size: 16)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.widthAnchor.constraint(equalToConstant: 150).isActive = true
        title.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35).isActive = true
        
        
        container.addSubview(category)
        category.text = data.category
        category.textColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        category.font = UIFont(name: "HacenSaudiArabiaXL", size: 17)
        category.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        category.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5).isActive = true
        category.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        container.addSubview(imageViewer)
        imageViewer.contentMode = .scaleAspectFill
        imageViewer.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageViewer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5).isActive = true
        imageViewer.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageViewer.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
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
