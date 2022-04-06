//
//  DailyForecastTableCell.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

final class DailyForecastTableCell: UITableViewCell {

    // MARK: - UI Variables

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = WAConstant.Margin.small
        view.distribution = .fillEqually
        return view
    }()

    private(set) lazy var dateLabel: UILabel = {
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

    private(set) lazy var lowTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = .zero
        view.imageView.image = UIImage(systemName: "chevron.down")
        return view
    }()

    private(set) lazy var upTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = .zero
        view.imageView.image = UIImage(systemName: "chevron.up")
        return view
    }()

    // MARK: - View Lifecycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyForecastTableCell {
    private func setupViews() {

        self.setupContentStackView()
        self.contentStackView.addArrangedSubview(self.dateLabel)
        self.setupDetailSection()
    }

    private func setupContentStackView() {

        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(WAConstant.Margin.small)
            make.top.equalTo(WAConstant.Margin.small)
        }
    }

    private func setupDetailSection() {

        let stack = UIStackView(arrangedSubviews: [weatherImageView,
                                                   UIView(),
                                                   lowTrendImageLabel,
                                                   upTrendImageLabel])
        stack.spacing = WAConstant.Margin.small
        self.contentStackView.addArrangedSubview(stack)
    }
}
