//
//  NewsFilterViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 14.12.2020.
//

import UIKit

protocol NewsFilterViewProtocol: class {
    var dateTime: Date { get }
    func applyOnTap()
    func resetOnTap()
    func switchDate(flag: Bool, animated: Bool)
    func dateFilterOnTap()
}

class NewsFilterViewController: UIViewController, StoryboardInit {
    
    var presenter: NewsFilterPresenterProtocol!

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var filtersTable: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    @IBOutlet weak var apply: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: R.string.localizable.resetLabel(), style: .plain, target: self, action: #selector(resetOnTap))]
        apply.addTarget(self, action: #selector(applyOnTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apply.layer.cornerRadius = apply.bounds.height / 2
        datePicker.datePickerMode = .date
        datePicker.date = presenter.date
        presenter.updateUI()
    }
}

extension NewsFilterViewController: NewsFilterViewProtocol {
    var dateTime: Date {
        return self.datePicker.date
    }
    
    @objc func applyOnTap() {
        presenter.applyOnTap()
    }
    
    @objc func resetOnTap() {
        presenter.resetOnTap()
    }
    
    func switchDate(flag: Bool, animated: Bool) {
        self.pickerHeight.constant = flag ? 200 : 0
        self.container.isHidden = !flag
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            return
        }
        self.view.layoutIfNeeded()
    }
    
    func dateFilterOnTap() {
        
    }
}

extension NewsFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell else {
            assertionFailure("Unable to init FilterTableViewCell")
            return
        }
        
        cell.filterStatus.setOn(!cell.filterStatus.isOn, animated: true)
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}

extension NewsFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.filterCell, for: indexPath)
        guard let tableCell = cell else {
            assertionFailure("Unable to init FilterTableViewCell")
            return UITableViewCell()
        }
        tableCell.filterLabel.text = presenter.filterLabelAt(indexPath: indexPath)
        tableCell.filterStatus.setOn(presenter.setOnAt(indexPath: indexPath), animated: false)
        return tableCell
    }
}
