//
//  InTheRoomVM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import Foundation
import UIKit

class InTheRoomVM: NSObject {
    private var collectionView: UICollectionView!
    private var margin: CGFloat = 0
}
//MARK: ====> Configuration <====
extension InTheRoomVM: ConfigList {
    
    typealias T = UICollectionView
    func config(item: UICollectionView) {
        self.collectionView = item
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func refreshData() {
        self.collectionView.reloadData {}
    }
    var numberOfRow: Int {
        return 10
    }
}
//MARK: CollectionView Delegate / Datasource
extension InTheRoomVM: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = InTheRoomCell.dequeue(from: self.collectionView, for: indexPath) else { return UICollectionViewCell() }
        cell.setupData(index: indexPath.row, self)
        return cell
    }
}
extension InTheRoomVM: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
//MARK: Cell Delegate
extension InTheRoomVM: InTheRoomCellDelegate {
    func inTheCell(_ cell: InTheRoomCell, didSelectedAtThumb index: Int) {
        
    }
    func inTheCell(_ cell: InTheRoomCell, didSelectedAtHeart index: Int) {
        
    }
}


