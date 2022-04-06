//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit
import WeatherCore

final class DetailWeatherView: UIView, DiffableCollectionView {

    // MARK: - Constants

    typealias Entity = DetailWeatherModel
    typealias CellType = DetailWeatherCollectionCell

    // MARK: - Logical Variables

    lazy var datasource: DataSource = configureDataSource()

    // MARK: - UI Variables

    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let inset = WAConstant.Margin.standard
        layout.sectionInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        return layout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let view = WADynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(CellType.self, forCellWithReuseIdentifier: CellType.id)
        return view
    }()

    // MARK: - View Lifecycles

    init() {
        super.init(frame: .zero)
        self.collectionView.dataSource = self.datasource
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configureDataSource() -> DataSource {

        DataSource(collectionView: self
            .collectionView) { collectionView, indexPath, model -> UICollectionViewCell? in

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.id,
                                                              for: indexPath) as? CellType
                cell?.titleLabel.text = model.title
                cell?.subtitleLabel.text = model.value
                return cell
        }
    }

    private func setupViews() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(2 * WAConstant.ControlHeight.big)
        }
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
