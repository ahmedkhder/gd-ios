//
//  RoomWatchVM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 08/01/21.
//

import Foundation
import UIKit

class RoomWatchVM: NSObject {
    private var tblView: UITableView!
    private var animationsQueue = ChainedAnimationsQueue()
    var selectedListener: SelectedListener<String> = nil
}
//MARK: Configuration
extension RoomWatchVM: ConfigList {
    typealias T = UITableView
    func config(item: UITableView) {
        self.tblView = item
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.removeFooterView()
        RoomWatchCell.register(in: self.tblView)
    }
    func refreshData() {
        self.tblView.reloadData {}
    }
    var numberOfRow: Int {
        return 10
    }
}
//MARK: TableView Datasource & Delegate
extension RoomWatchVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = RoomWatchCell.dequeue(from: self.tblView) else { return UITableViewCell() }
        cell.setupData("", delegate: self, for: indexPath.row)
        return cell
    }
}
extension RoomWatchVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedListener?(indexPath.row, "")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      cell.alpha = 0.0
      animationsQueue.queue(withDuration: 0.2, initializations: {
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, cell.frame.size.width, 0, 0)
      }, animations: {
        cell.alpha = 1.0
        cell.layer.transform = CATransform3DIdentity
      })
    }
}
//MARK: Cell Delegate
extension RoomWatchVM: CellCommonDelegate {
    func tableViewCell(_ cell: UITableViewCell, didPressOn action: CellActionType, tag: Int) {
        switch action {
        case .kHeart: break
        case .kThumb: break
        }
    }
}
