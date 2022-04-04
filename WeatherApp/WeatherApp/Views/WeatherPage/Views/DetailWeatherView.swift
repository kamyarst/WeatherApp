//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

final class DetailWeatherView: UIView {

    private typealias CellType = DetailWeatherCollectionCell

    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let inset = WAConstant.Margin.standard
        layout.sectionInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        return layout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let view = WADynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(CellType.self, forCellWithReuseIdentifier: CellType.id)
        return view
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDataSource

extension DetailWeatherView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.id,
                                                            for: indexPath) as? CellType
        else { fatalError() }
        return cell
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension DetailWeatherView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.bounds.width / 2) - WAConstant.Margin.veryBig
        return CGSize(width: width, height: WAConstant.ControlHeight.big)
    }
}
