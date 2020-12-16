//
//  NewsFilterViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 14.12.2020.
//

import UIKit

class NewsFilterViewController: UIViewController, StoryboardInit {
    
    @IBOutlet weak var filtersTable: UITableView!
    @IBOutlet weak var dateTime: UIDatePicker!
    var presenter: NewsFilterPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyOnTap))]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
}

extension NewsFilterViewController: NewsFilterViewProtocol {
    @objc func applyOnTap() {
        presenter?.applyOnTap()
    }
}

extension NewsFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath)
    }
}

extension NewsFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterTableViewCell
        cell.filterLabel.text = presenter?.filterLabelAt(indexPath: indexPath)
        cell.filterStatus.setOn(presenter?.setOnAt(indexPath: indexPath) ?? false, animated: false)
        return cell
    }
}
