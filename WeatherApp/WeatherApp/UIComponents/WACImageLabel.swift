//
//  WACImageLabel.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit

final class WACImageLabel: UIView {

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = WAConstant.Margin.small.value
        view.alignment = .center
        return view
    }()

    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()

    internal init() {
        super.init(frame: .zero)

        self.setupViews()
        self.setTintColor(with: .lightText)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTintColor(with color: UIColor) {

        self.imageView.tintColor = color
        self.titleLabel.textColor = color
    }
}

extension WACImageLabel {

    private func setupViews() {

        self.setupContentStackView()
        self.setupContentViews()
    }

    private func setupContentStackView() {

        self.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setImage(size: CGFloat) {
        self.imageView.snp.updateConstraints { make in
            make.size.equalTo(size)
        }
    }

    private func setupContentViews() {

        self.contentStackView.addArrangedSubview(self.imageView)
        self.contentStackView.addArrangedSubview(self.titleLabel)
        self.setImage(size: 18)
    }
}
