//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

final class DailyForecastView: UIView {

    private typealias CellType = DailyForecastTableCell

    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = WAConstant.Margin.small
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .lightText
        view.text = L10n.WeatherController.DailyForecast.title
        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CellType.self, forCellReuseIdentifier: CellType.id)
        view.dataSource = self
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.separatorStyle = .none
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
        self.setupTableView()
    }

    private func setupContentStackView() {

        self.addSubview(self.contentStackView)
        self.contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.leading.equalTo(WAConstant.Margin.standard)
        }
    }

    private func setupTableView() {

        self.contentStackView.addArrangedSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            let height = tableView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
            make.height.equalTo(height)
        }
    }
}

// MARK: UITableViewDataSource

extension DailyForecastView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.id,
                                                       for: indexPath) as? DailyForecastTableCell
        else { return UITableViewCell() }

        return cell
    }
}
