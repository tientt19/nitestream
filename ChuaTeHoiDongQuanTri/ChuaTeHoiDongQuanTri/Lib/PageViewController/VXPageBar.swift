//
//  PageBar.swift
//  1SK
//
//  Created by tuyenvx on 10/05/2021.
//

import Foundation
import SnapKit
import UIKit

protocol VXPageBarDelegate: AnyObject {
    func onItemDidSelected(at index: Int)
}

class VXPageBar: UIView {
    private var items: [VXPageBarItem] = []
    private lazy var stackView = self.createStackView()
    private var config = VXPageBarConfig()
    private var underLine: UIView = UIView()
    private var pageBarHeightConstraint: NSLayoutConstraint!
    private var underLineViewLeadingConstraint: NSLayoutConstraint!
    private var underLineViewHeightConstraint: NSLayoutConstraint!
    private var underLineViewWidthConstraint: NSLayoutConstraint!
    private var selectedIndex: Int = 0
    private var barHeight: CGFloat {
        return self.config.height
    }
    var selectedColor: UIColor {
        return self.config.selectedColor
    }
    var unselectedColor: UIColor {
        return self.config.unSelectedColor
    }
    var underLineColor: UIColor {
        return self.config.underLineColor
    }
    var underLineHeight: CGFloat {
        return self.config.underLineHeight
    }

    weak var delegate: VXPageBarDelegate?

    private var numberOfPage: Int {
        return self.items.count
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDefaults()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDefaults()
    }

    init(items: [VXPageBarItem]) {
        super.init(frame: .zero)
        self.setupDefaults()
        self.items = items
        self.setConfig(self.config)
    }
    
    // MARK: - Setup
    private func setupDefaults() {
        self.addSubview(stackView)
        let breakLineView = UIView()
        breakLineView.backgroundColor = UIColor(hex: "E7ECF0")
        self.addSubview(breakLineView)
        self.addSubview(underLine)
        self.pageBarHeightConstraint = heightAnchor.constraint(equalToConstant: self.barHeight)
        NSLayoutConstraint.activate([
            self.pageBarHeightConstraint
        ])

        self.underLine.translatesAutoresizingMaskIntoConstraints = false
        self.underLineViewLeadingConstraint = self.underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.underLineViewHeightConstraint = self.underLine.heightAnchor.constraint(equalToConstant: self.underLineHeight)
        self.underLineViewWidthConstraint = self.underLine.widthAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //
            self.underLine.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            self.underLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.underLineViewHeightConstraint,
            self.underLineViewLeadingConstraint,
            self.underLineViewWidthConstraint
        ])

        breakLineView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }

    }
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func createBarItemView() {
        self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

        for (index, item) in self.items.enumerated() {
            let button = UIButton()
            button.tag = index
            if let icon = item.icon  {
                button.setImage(UIImage(named: icon), for: .normal)
            } else {
                button.setTitle(item.title, for: .normal)
            }
            
            button.addTarget(self, action: #selector(self.onButtonDidTapped(_:)), for: .touchUpInside)
            self.stackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Action
    func setItems(_ items: [VXPageBarItem]) {
        self.items = items
        self.createBarItemView()
        self.setSelectedIndex(self.selectedIndex)
        let fullWidth = Constant.Screen.width / CGFloat(self.numberOfPage)
        let underLineViewWidth = self.config.underLineWidth != nil ? self.config.underLineWidth! : fullWidth
        self.underLineViewWidthConstraint.constant = underLineViewWidth
        self.underLineViewLeadingConstraint.constant = fullWidth * CGFloat(self.selectedIndex) + (fullWidth - (self.config.underLineWidth ?? fullWidth)) / 2
        self.layoutIfNeeded()
    }

    @objc func onButtonDidTapped(_ sender: UIButton) {
        let index = sender.tag
        self.delegate?.onItemDidSelected(at: index)
    }

    func setSelectedIndex(_ index: Int) {
        self.selectedIndex = index
        for button in stackView.arrangedSubviews.compactMap({ $0 as? UIButton }) {
            let isSelected = button.tag == index
            button.setTitleColor(!isSelected ? self.unselectedColor : self.selectedColor, for: .normal)
            button.titleLabel?.font = isSelected ? self.config.selectedFont : self.config.unSelectedFont
        }
    }

    func updateUnderlineLeadingConstraint(with constant: CGFloat) {
        let fullWidth = Constant.Screen.width / CGFloat(self.numberOfPage)
        let underLineViewWidth = self.config.underLineWidth != nil ? self.config.underLineWidth! : fullWidth
        self.underLineViewWidthConstraint?.constant = underLineViewWidth
        let offset = (fullWidth - (self.config.underLineWidth ?? fullWidth)) / 2
        self.underLineViewLeadingConstraint.constant = constant + offset
    }

    func setConfig(_ config: VXPageBarConfig) {
        self.config = config
        self.reloadConfig()
    }
    
    // MARK: - Helper
    private func reloadConfig() {
        self.pageBarHeightConstraint.constant = self.config.height
        self.setSelectedIndex(self.selectedIndex)
        self.underLine.backgroundColor = self.config.underLineColor
        self.underLineViewHeightConstraint?.constant = self.config.underLineHeight
        self.underLine.cornerRadius = self.underLineHeight / 2
        self.backgroundColor = self.config.backgroundColor
        self.stackView.backgroundColor = self.config.backgroundColor
        guard self.numberOfPage != 0 else {
            return
        }
        let fullWidth = Constant.Screen.width / CGFloat(self.numberOfPage)
        let underLineViewWidth = self.config.underLineWidth != nil ? self.config.underLineWidth! : fullWidth
        self.underLineViewWidthConstraint?.constant = underLineViewWidth
        self.underLineViewLeadingConstraint?.constant = fullWidth * CGFloat(self.selectedIndex) + (fullWidth - (self.config.underLineWidth ?? fullWidth)) / 2
    }
}

// MARK: - VXPageBarItem
class VXPageBarItem {
    var title: String?
    var icon: String?

    init(title: String) {
        self.title = title
    }
    
    init(icon: String) {
        self.icon = icon
    }
}

// MARK: - VXPageBarConfig
struct VXPageBarConfig {
    var height: CGFloat = 50
    var selectedColor: UIColor = .black
    var unSelectedColor: UIColor = .gray
    var selectedFont: UIFont?
    var unSelectedFont: UIFont?
    var underLineHeight: CGFloat = 4
    var underLineWidth: CGFloat?
    var underLineColor: UIColor = .black
    var backgroundColor: UIColor = .white

    init() {
        self.height = 50
        self.selectedColor = .black
        self.unSelectedColor = .gray
        self.underLineHeight = 4
        self.underLineColor = .black
        self.backgroundColor = .white
    }

    init(height: CGFloat? = nil,
         selectedColor: UIColor? = nil,
         unSelectedColor: UIColor? = nil,
         selectedFont: UIFont? = nil,
         unSelectedFont: UIFont? = nil,
         underLineHeight: CGFloat? = nil,
         underLineWidth: CGFloat? = nil,
         underLineColor: UIColor? = nil,
         backgroundColor: UIColor? = nil) {
        
        if let `height` = height {
            self.height = height
        }

        if let `selectedColor` = selectedColor {
            self.selectedColor = selectedColor
        }

        if let `unSelectedColor` = unSelectedColor {
            self.unSelectedColor = unSelectedColor
        }

        if let `underLineHeight` = underLineHeight {
            self.underLineHeight = underLineHeight
        }

        if let `underLineColor` = underLineColor {
            self.underLineColor = underLineColor
        }

        if let `backgroundColor` = backgroundColor {
            self.backgroundColor = backgroundColor
        }

        self.selectedFont = selectedFont
        self.unSelectedFont = unSelectedFont
        self.underLineWidth = underLineWidth
    }
}
