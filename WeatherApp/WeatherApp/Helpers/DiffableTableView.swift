//
//  DiffableTableView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import UIKit

protocol DiffableTableView {

    typealias CellType = UITableViewCell
    typealias DataSource = UITableViewDiffableDataSource<Section, Entity>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Entity>
    associatedtype Entity: Hashable
    var datasource: DataSource { get }

    func configureDataSource() -> DataSource
    func updateSnapshot(with items: [Entity])
}

extension DiffableTableView {

    func updateSnapshot(with items: [Entity]) {

        var snapshot = Snapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(items, toSection: .all)

        self.datasource.apply(snapshot, animatingDifferences: true)
    }
}
