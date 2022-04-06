//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit
import WeatherCore

final class DailyForecastView: UIView, DiffableTableView {

    // MARK: - Constants

    typealias Entity = ForecastDayModel
    private typealias CellType = DailyForecastTableCell

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
        view.text = L10n.WeatherController.DailyForecast.title
        return view
    }()

    private(set) lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CellType.self, forCellReuseIdentifier: CellType.id)
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = WAConstant.ControlHeight.medium
        view.separatorStyle = .none
        return view
    }()

    // MARK: - View Lifecycles

    init() {
        super.init(frame: .zero)

        self.tableView.dataSource = self.datasource
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configureDataSource() -> DataSource {

        DataSource(tableView: self.tableView) { tableView, indexPath, model -> UITableViewCell? in

            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.id, for: indexPath) as? CellType

            cell?.dateLabel.text = Date(timeIntervalSince1970: TimeInterval(model.dateEpoch)).dayOfWeekText
            cell?.upTrendImageLabel.titleLabel.text = "\(Int(model.day.maxtempC))"
            cell?.lowTrendImageLabel.titleLabel.text = "\(Int(model.day.mintempC))"
            let icon = model.day.condition.code
            if let imageName = WeatherIconFactory.get(code: icon, isDay: 1) {
                cell?.weatherImageView.image = UIImage(systemName: imageName)
            }
            return cell
        }
    }
}

// MARK: - SetupViews

extension DailyForecastView {

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
        self.tableView.snp.updateConstraints { make in
            make.height.equalTo(3 * WAConstant.ControlHeight.small)
        }
    }

    private func updateTableViewHeight() {

        self.tableView.snp.updateConstraints { make in
            let height = tableView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            make.height.equalTo(height)
        }
    }
}
