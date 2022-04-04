//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit

final class HourlyForecastView: UIView {

    private typealias CellType = HourlyForecastCollectionCell

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = WAConstant.Margin.small.value
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = L10n.WeatherController.Forecast.title
        return view
    }()

    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let inset = WAConstant.Margin.small.value
        layout.sectionInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        return layout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = false
        view.register(CellType.self, forCellWithReuseIdentifier: CellType.id)
        return view
    }()

    init() {
        super.init(frame: .zero)

        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {

        self.setupContentStackView()
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.setupCollectionView()
    }

    private func setupContentStackView() {

        self.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.center.top.equalToSuperview()
            make.leading.equalTo(WAConstant.Margin.standard.value)
        }
    }

    private func setupCollectionView() {

        self.contentStackView.addArrangedSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            let width = WAConstant.ControlHeight.big.value
            let ratio: CGFloat = 2
            make.height.equalTo(width * ratio)
        }
    }
}

// MARK: UICollectionViewDataSource

extension HourlyForecastView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.id,
                                                            for: indexPath) as? CellType
        else { fatalError() }
        return cell
    }
}
