//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit

final class CurrentWeatherView: UIView {

    // MARK: - Constants

    // MARK: - Logical Variables

    // MARK: - UI Variables

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = WAConstant.Margin.medium
        return view
    }()

    private lazy var currentStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.spacing = WAConstant.Margin.medium
        return view
    }()

    private(set) lazy var currentIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()

    private(set) lazy var currentDegreeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "-"
        view.font = WAFont.fixedFont(.bold, 75)
        return view
    }()

    private(set) lazy var unitLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = UnitTemperature.celsius.symbol
        view.font = WAFont.dynamicFont(.medium, .largeTitle)
        return view
    }()

    private(set) lazy var feelLikeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = "Feels like -"
        return view
    }()

    private(set) lazy var currentWeatherLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = "-"
        return view
    }()

    private(set) lazy var locationLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = WAFont.dynamicFont(.bold, .largeTitle)
        view.text = "-"
        return view
    }()

    private(set) lazy var regionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = "-"
        return view
    }()

    private lazy var trendStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = WAConstant.Margin.veryBig
        return view
    }()

    private(set) lazy var lowTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = WAConstant.Margin.verySmall
        view.titleLabel.text = "-" + UnitTemperature.celsius.symbol
        view.imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        return view
    }()

    private(set) lazy var upTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = WAConstant.Margin.verySmall
        view.titleLabel.text = "-" + UnitTemperature.celsius.symbol
        view.imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        return view
    }()

    // MARK: - View Lifecycles

    init() {
        super.init(frame: .zero)

        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrentWeatherView {

    private func setupViews() {

        self.setupContentStackView()
        self.setupCurrentIconImageView()
        self.contentStackView.addArrangedSubview(self.locationLabel)
        self.contentStackView.addArrangedSubview(self.regionLabel)
        self.currentStackView.addArrangedSubview(self.currentDegreeLabel)
        self.currentStackView.addArrangedSubview(self.unitLabel)
        self.contentStackView.addArrangedSubview(self.currentStackView)
        self.contentStackView.addArrangedSubview(self.trendStackView)
        self.trendStackView.addArrangedSubview(self.lowTrendImageLabel)
        self.trendStackView.addArrangedSubview(self.upTrendImageLabel)
        self.contentStackView.addArrangedSubview(self.feelLikeLabel)
        self.contentStackView.addArrangedSubview(self.currentWeatherLabel)
    }

    private func setupContentStackView() {

        self.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupCurrentIconImageView() {
        self.currentStackView.addArrangedSubview(self.currentIconImageView)
        self.currentIconImageView.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
    }
}
