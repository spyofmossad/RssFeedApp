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
}

class NewsFilterViewController: UIViewController, StoryboardInit {
    
    var presenter: NewsFilterPresenterProtocol!
    
    @IBOutlet weak var filtersTable: UITableView!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var apply: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetOnTap))]
        apply.addTarget(self, action: #selector(applyOnTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apply.layer.cornerRadius = apply.bounds.height / 2
        dateTimePicker.datePickerMode = .date
        dateTimePicker.date = presenter.date
    }
}

extension NewsFilterViewController: NewsFilterViewProtocol {
    var dateTime: Date {
        return self.dateTimePicker.date
    }
    
    @objc func applyOnTap() {
        presenter.applyOnTap()
    }
    
    @objc func resetOnTap() {
        presenter.resetOnTap()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterTableViewCell
        guard let tableCell = cell else {
            assertionFailure("Unable to init FilterTableViewCell")
            return UITableViewCell()
        }
        tableCell.filterLabel.text = presenter.filterLabelAt(indexPath: indexPath)
        tableCell.filterStatus.setOn(presenter.setOnAt(indexPath: indexPath), animated: false)
        return tableCell
    }
}
