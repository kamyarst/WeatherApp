//
//  DetailWeatherCollectionCell.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

final class DetailWeatherCollectionCell: UICollectionViewCell {

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = "title"
        return view
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "subtitle"
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {

        self.setupContentStackView()
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.contentStackView.addArrangedSubview(self.subtitleLabel)
    }

    private func setupContentStackView() {
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
