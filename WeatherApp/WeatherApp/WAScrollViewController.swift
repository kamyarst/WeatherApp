//
//  WAScrollViewController.swift
//  WeatherUI
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

class WAScrollViewController: UIViewController {

    private(set) lazy var containerView = UIView()
    private(set) lazy var scrollView = UIScrollView()

    override func loadView() {
        super.loadView()

        self.setupViews()
    }

    private func setupViews() {

        self.setupScrollView()
        self.setupContainerView()
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
}
