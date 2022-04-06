//
//  HourlyForecastCollectionCell.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit

final class HourlyForecastCollectionCell: UICollectionViewCell {

    // MARK: - UI Variables

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = WAConstant.Margin.small
        view.alignment = .center
        return view
    }()

    private(set) lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()

    private(set) lazy var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()

    private(set) lazy var weatherLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()

    // MARK: - View Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.configBackgroundView()
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Configurations

    private func configBackgroundView() {

        self.contentView.backgroundColor = .white.withAlphaComponent(0.3)
        self.contentView.layer.cornerRadius = 16
    }
}

extension HourlyForecastCollectionCell {
    private func setupViews() {

        self.setupContentStackView()
        self.setupContentSubStackView()
    }

    private func setupContentStackView() {

        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.leading.equalTo(WAConstant.Margin.small)
        }
    }

    private func setupContentSubStackView() {

        self.contentStackView.addArrangedSubview(self.timeLabel)
        self.contentStackView.addArrangedSubview(self.weatherImageView)
        self.contentStackView.addArrangedSubview(self.weatherLabel)
    }
}
