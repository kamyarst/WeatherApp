//
//  WAScrollViewController.swift
//  WeatherUI
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

class WAScrollViewController: UIViewController {

    private(set) lazy var scrollView = UIScrollView()
    private(set) lazy var containerView = UIView()

    private(set) lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = WAConstant.Margin.standard
        view.axis = .vertical
        return view
    }()

    override func loadView() {
        super.loadView()

        self.setupViews()
    }

    private func setupViews() {

        self.setupScrollView()
        self.setupContainerView()
        self.setupContainerStackView()
    }

    private func setupScrollView() {

        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupContainerView() {

        self.scrollView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.view)
        }
    }

    private func setupContainerStackView() {

        self.containerView.addSubview(self.containerStackView)
        self.containerStackView.snp.makeConstraints { make in
            make.centerX.topMargin.bottomMargin.leading.equalToSuperview()
        }
    }
}
