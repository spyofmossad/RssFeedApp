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
    @IBOutlet weak var feedTitle: UITextField!
    @IBAction func titleChanged(_ sender: UITextField) {
        presenter?.textFieldShouldReturn(tag: sender.tag, textFieldText: sender.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.disableSaveButton()
        presenter?.viewDidLoad()
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
    var feedTitleText: String {
        return feedTitle.text ?? ""
    }
    
    var feedUrl: String {
        return url.text ?? ""
    }
    
    var feedCategories: [String] {
        return [String]()
    }
    
    func activateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func disableSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func showPlaceholder() {
        showPlaceholder(in: categoriesTable, with: "No categories")
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
    
    func updateUI(url: String, title: String, categories: [String]) {
        self.url.text = url
        self.feedTitle.text = title
        categories.count > 0 ?
            self.categoriesTable.reloadData() :
            self.showPlaceholder()
    }
}

extension AddEditFeedViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == url {
            presenter?.textFieldShouldReturn(tag: textField.tag, textFieldText: textField.text)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case url:
            feedTitle.becomeFirstResponder()
        case feedTitle:
            feedTitle.resignFirstResponder()
        default:
            break
        }
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
