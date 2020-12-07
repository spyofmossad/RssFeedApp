//
//  AddEditFeedViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

class AddEditFeedViewController: UIViewController, StoryboardInit {
    
    var presenter: AddFeedPresenterProtocol?
    
    private var categories: [String]?

    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var rssTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.isEnabled = false
        presenter?.updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        categoriesTable.layer.borderColor = UIColor.lightGray.cgColor
        categoriesTable.layer.borderWidth = 1.0
    }
    
    //proxy method to avoid mark protocol as @objc
    @objc private func save() {
        saveChanges()
    }
}

extension AddEditFeedViewController: AddFeedViewProtocol {
    func showUrl(url: String?) {
        self.url.text = url
    }
    
    func showTitle(title: String?) {
        self.rssTitle.text = title
    }
    
    func activateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func showPlaceholder() {
        showPlaceholder(in: categoriesTable, with: "No categories were found")
    }
    
    func showCategories(categories: [String]) {
        self.categories = categories
        categoriesTable.reloadData()
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
    
    func showSpinner() {
        showActivityIndicator()
    }
    
    func removeSpinner() {
        hideActivityIndicator()
    }
    
    func saveChanges() {
        presenter?.saveChanges()
    }
    
}

extension AddEditFeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.textFieldShouldReturn(userInput: textField.text)
        return true
    }
}

extension AddEditFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categories?[indexPath.row]
        return cell
    }
}
