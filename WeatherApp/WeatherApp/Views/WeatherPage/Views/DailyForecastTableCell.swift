//
//  DailyForecastTableCell.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

final class DailyForecastTableCell: UITableViewCell {

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = WAConstant.Margin.small
        view.distribution = .fillEqually
        return view
    }()

    private(set) lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Saturday"
        return view
    }()

    private(set) lazy var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "cloud.sun.rain.fill")?.withRenderingMode(.alwaysOriginal)
        return view
    }()

    private(set) lazy var lowTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = .zero
        view.titleLabel.text = "12"
        view.imageView.image = UIImage(systemName: "chevron.down")
        return view
    }()

    private(set) lazy var upTrendImageLabel: WACImageLabel = {
        let view = WACImageLabel()
        view.contentStackView.spacing = .zero
        view.titleLabel.text = "20"
        view.imageView.image = UIImage(systemName: "chevron.up")
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
