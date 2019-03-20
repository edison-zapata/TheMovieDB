//
//  Views.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/18/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
import UIKit

protocol ListView {
    
    var listDelegate: ListViewDelegate? { get set }
    
    func reloadData()
    
}

class ListTableView : UITableView, ListView {
    
    weak var listDelegate: ListViewDelegate?
    
    let cellIdentifier = "ListTableCell"
    
    override init(frame: CGRect, style: UITableView.Style){
        super.init(frame: frame, style: style)
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListTableView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDelegate?.getCellsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListCell
        listDelegate?.modifyCell(cell, cellForItemAt: indexPath)
        return cell as! UITableViewCell
    }
    
}

class ListCollectionView : UICollectionView, ListView {
    
    weak var listDelegate: ListViewDelegate?
    
    let cellIdentifier = "ListCollectionCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDelegate?.getCellsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ListCell
        listDelegate?.modifyCell(cell, cellForItemAt: indexPath)
        return cell as! UICollectionViewCell
    }
    
}
