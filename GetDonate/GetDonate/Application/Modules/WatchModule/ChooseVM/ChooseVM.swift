//
//  ChooseVM.swift
//  GetDonate
//
//  Created by Shiva Kr. on 29/01/21.
//

import Foundation
import UIKit


class ChooseVM: NSObject {
    private var tblView: UITableView!
}
extension ChooseVM: ConfigList {
    typealias T = UITableView

    func config(item: UITableView) {
        self.tblView = item
        self.tblView.delegate = self
        self.tblView.dataSource = self
        ChooseRoomCell.register(in: self.tblView)
    }
    func refreshData() {
        self.tblView.reloadData {}
    }
    
    var numberOfRow: Int {
        return 10
    }
}
//MARK: TableView DataSource
extension ChooseVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ChooseRoomCell.dequeue(from: tableView) else {
            return UITableViewCell()
        }
        return cell
    }
}
extension ChooseVM: UITableViewDelegate {
    
}
