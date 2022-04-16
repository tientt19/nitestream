//
//  VXPageViewController.swift
//  1SK
//
//  Created by tuyenvx on 10/05/2021.
//

import Foundation
import UIKit

protocol VXPageViewDelegate: AnyObject {
    func onDidChangeSelectedPage(at index: Int)
}

class VXPageViewController: UIViewController {
    private lazy var pageBar: VXPageBar = VXPageBar(items: [])
    private var pageItems: [VXPageItem] = []
    lazy var scrollView = createScrollView()
    private lazy var stackView = createStackView()
    var selectedIndex: Int = 0
    
    weak var delegate: VXPageViewDelegate?
    
    private var stackViewWidthConstraint: NSLayoutConstraint!
    private var scrollViewWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    private var numberOfPage: Int {
        return pageItems.count
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setupDefaults()
    }

    init(selectedIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        setupDefaults()
        self.selectedIndex = selectedIndex
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectedIndex(selectedIndex)
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if let interactivePopGesture = parent?.navigationController?.interactivePopGestureRecognizer {
            scrollView.panGestureRecognizer.require(toFail: interactivePopGesture)
            parent?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    // MARK: - Setup
    private func setupDefaults() {
        view.addSubview(pageBar)
        pageBar.delegate = self
        pageBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageBar.topAnchor.constraint(equalTo: view.topAnchor),
            pageBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: pageBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewWidthConstraint = stackView.widthAnchor.constraint(equalToConstant: scrollViewWidth)
        NSLayoutConstraint.activate([
            stackViewWidthConstraint,
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }

    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func addPageItemsView() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview()})
        stackViewWidthConstraint.constant = scrollViewWidth * CGFloat(numberOfPage)
        for item in pageItems {
            let containerView = UIView()
            stackView.addArrangedSubview(containerView)
            addChild(item.viewController)
            item.viewController.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(item.viewController.view)
            NSLayoutConstraint.activate([
                item.viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                item.viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                item.viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                item.viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            item.viewController.didMove(toParent: self)
        }
        view.layoutIfNeeded()
        setSelectedIndex(selectedIndex)
    }
    // MARK: - Action
    func setPageItems(_ items: [VXPageItem]) {
        self.pageItems = items
        self.pageBar.setItems(items.map({ $0.pageBarItem }))
        addPageItemsView()
    }

    func setSelectedIndex(_ index: Int, animated: Bool = false) {
        pageBar.setSelectedIndex(index)
        DispatchQueue.main.async {
            self.scrollView.setContentOffset(CGPoint(x: self.scrollViewWidth * CGFloat(index), y: 0), animated: animated)
        }
    }

    func setPageBarConfig(_ config: VXPageBarConfig) {
        pageBar.setConfig(config)
    }
}
// MARK: - UIScrollViewDelegate
extension VXPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        pageBar.updateUnderlineLeadingConstraint(with: contentOffset.x / CGFloat(numberOfPage))
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let page = Int(contentOffset.x / scrollView.bounds.width)
        pageBar.setSelectedIndex(page)
        self.delegate?.onDidChangeSelectedPage(at: page)
    }
}
// MARK: - PageBarDelegate
extension VXPageViewController: VXPageBarDelegate {
    func onItemDidSelected(at index: Int) {
        self.setSelectedIndex(index, animated: true)
        self.delegate?.onDidChangeSelectedPage(at: index)
    }
}
