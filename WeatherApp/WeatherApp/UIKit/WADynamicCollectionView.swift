//
//  WADynamicCollectionView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

class WADynamicCollectionView: UICollectionView {

    override var intrinsicContentSize: CGSize {
        self.collectionViewLayout.collectionViewContentSize
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
