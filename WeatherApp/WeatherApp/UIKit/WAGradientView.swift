//
//  WAGradientView.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

protocol WAGradientViewProtocol: UIView {
    var gradient: CAGradientLayer? { get set }
    var gradientColors: [UIColor] { get set }
    var gradientType: GradientType { get set }

    func updateGradientSize()
    func configGradient(with colors: [UIColor], _ mode: GradientType)
    func applyGradientView()
}

enum GradientType {
    case vertical
    case horizontal

    var startPoint: CGPoint {
        switch self {
        case .vertical: return CGPoint(x: 1, y: 0)
        case .horizontal: return CGPoint(x: 0, y: 1)
        }
    }

    var endPoint: CGPoint {
        switch self {
        case .vertical: return CGPoint(x: 1, y: 1)
        case .horizontal: return CGPoint(x: 1, y: 1)
        }
    }
}

extension WAGradientViewProtocol {

    func updateGradientSize() {

        guard let gradient = self.gradient else { return }
        gradient.frame = self.bounds
    }

    func configGradient(with colors: [UIColor], _ mode: GradientType) {

        self.gradientColors = colors
        self.gradientType = mode
    }

    func applyGradientView() {

        let gradient = self.setGradient(with: self.gradientColors, self.gradientType)
        self.gradient = gradient
        guard self.gradient?.superlayer == nil else { return }
        self.layer.insertSublayer(gradient, at: 0)
    }

    private func setGradient(with colors: [UIColor], _ mode: GradientType = .horizontal) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = mode.startPoint
        gradientLayer.endPoint = mode.endPoint
        gradientLayer.frame = self.bounds

        return gradientLayer
    }
}

final class WAGradientView: UIView, WAGradientViewProtocol {
    var gradient: CAGradientLayer?
    var gradientColors: [UIColor] = []
    var gradientType: GradientType = .vertical

    override var bounds: CGRect {
        didSet {
            self.updateGradientSize()
        }
    }

    override var frame: CGRect {
        didSet {
            self.updateGradientSize()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.applyGradientView()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        self.updateGradientSize()
    }
}
