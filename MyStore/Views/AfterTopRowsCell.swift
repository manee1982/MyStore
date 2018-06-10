//
//  AfterTopRowsCell.swift
//  MyStore
//
//  Created by Smart Visions on 5/16/18.
//  Copyright © 2018 Smart Visions. All rights reserved.
//

import UIKit

class AfterTopRowsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cellBg: [UIColor] = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.937254902, green: 0.8705882353, blue: 0.8, alpha: 1), #colorLiteral(red: 0.8078431373, green: 0.937254902, blue: 0.8, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.9803921569, green: 0.8745098039, blue: 0.8784313725, alpha: 1)]
    
    var collectionView: UICollectionView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        if let collectionView = collectionView {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = false
            
            collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
            
            addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell {
            
            if indexPath.row < 6 {
                cell.backgroundColor = cellBg[indexPath.row]
            }
            
            if let items = AppData.items {
                let index = indexPath.row + 2
                cell.setupViews(data: items[index])
            }
            
            return cell
        } else {
            return CollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 140)
    }
    
    
    
    
    

}
