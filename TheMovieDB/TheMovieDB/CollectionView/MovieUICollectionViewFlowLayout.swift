//
//  MovieUICollectionViewFlowLayout.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/13/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class MovieUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let cellWidth: CGFloat = 114
    let cellHeight: CGFloat = 170
    let spaceBetweenCells: CGFloat = 10
    
    override func prepare() {
        super.prepare()
        guard collectionView != nil else {
            return
        }
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        minimumInteritemSpacing = spaceBetweenCells
        minimumLineSpacing = spaceBetweenCells
        let contentSizeWidth = collectionViewContentSize.width
        //Divide the available space between the cell width plus the space between cells, adds once the space between cells to the available space to compensate the fact that this space is used n-1 times depending on the number of cells
        let cellsInRow = CGFloat(Int(((contentSizeWidth+spaceBetweenCells)/(cellWidth+spaceBetweenCells))))
        let spaceForCells = (cellWidth*cellsInRow)
        let totalInteritemSpace = (cellsInRow-1)*spaceBetweenCells
        let leftoverWidth = contentSizeWidth - spaceForCells - totalInteritemSpace
        sectionInset.left = leftoverWidth/2
        sectionInset.right = sectionInset.left
    }
}
