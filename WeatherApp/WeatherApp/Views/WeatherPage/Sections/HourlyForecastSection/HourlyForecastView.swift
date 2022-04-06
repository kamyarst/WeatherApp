//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit
import WeatherCore

final class HourlyForecastView: UIView, DiffableCollectionView {

    // MARK: - Constants

    typealias Entity = HourModel
    private typealias CellType = HourlyForecastCollectionCell

    // MARK: - Logical Variables

    lazy var datasource: DataSource = configureDataSource()

    // MARK: - UI Variables

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = WAConstant.Margin.small
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = L10n.WeatherController.HourlyForecast.title
        view.font = WAFont.dynamicFont(.medium, .footnote)
        return view
    }()

    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let inset = WAConstant.Margin.small
        layout.sectionInset = .init(top: 0, left: inset, bottom: 0, right: inset)
        return layout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = false
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
                cell?.timeLabel.text = Date(string: model.time).time
                cell?.weatherLabel.text = "\(Int(model.tempC))"
                let icon = model.condition.code
                if let imageName = WeatherIconFactory.get(code: icon, isDay: model.isDay) {
                    cell?.weatherImageView.image = UIImage(systemName: imageName)?
                        .withRenderingMode(.alwaysOriginal)
                }
                return cell
        }
    }
}

extension HourlyForecastView {
    private func setupViews() {

        self.setupContentStackView()
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.setupCollectionView()
    }

    private func setupContentStackView() {

        self.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.center.top.equalToSuperview()
            make.leading.equalTo(WAConstant.Margin.standard)
        }
    }

    private func setupCollectionView() {

        self.contentStackView.addArrangedSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            let width = WAConstant.ControlHeight.big
            let ratio: CGFloat = 2
            make.height.equalTo(width * ratio)
        }
    }
}
