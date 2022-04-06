//
//  DiffableCollectionView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import UIKit

protocol DiffableCollectionView {

    typealias CellType = UICollectionViewCell
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Entity>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Entity>
    associatedtype Entity: Hashable
    var datasource: DataSource { get }

    func configureDataSource() -> DataSource
    func updateSnapshot(with items: [Entity])
}

extension DiffableCollectionView {

    func updateSnapshot(with items: [Entity]) {

        var snapshot = Snapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(items, toSection: .all)

        self.datasource.apply(snapshot, animatingDifferences: true)
    }
}
