//
//  DevDiffableDataSource.swift
//  InternTuan
//
//  Created by Nguên Bản on 31/10/25.
//

import Foundation
import UIKit

final class DevDiffableDataSource: UITableViewDiffableDataSource<Issue11DDSViewController.Section, Developer> {
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let sectionID = snapshot().sectionIdentifiers[section]
//        return sectionID.rawValue
//    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        var snapshot = snapshot()
        if let item = itemIdentifier(for: indexPath) {
            snapshot.deleteItems([item])
            apply(snapshot, animatingDifferences: true)
        }
    }
}
