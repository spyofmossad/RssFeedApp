//
//  AddEditFeedViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

protocol AddFeedViewProtocol: class {
    var feedTitleText: String { get }
    var feedUrl: String { get }
    var feedCategories: [String] { get }
    
    func updateUI(url: String, title: String)
    func saveChanges()
    func showSpinner()
    func removeSpinner()
    func showError(message: String)
    func showPlaceholder()
    func activateSaveButton()
    func disableSaveButton()
}

class AddEditFeedViewController: UIViewController, StoryboardInit {
    
    var presenter: AddFeedPresenterProtocol!
    
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var feedTitle: UITextField!
    @IBAction func titleChanged(_ sender: UITextField) {
        presenter.textFieldShouldReturn(tag: sender.tag, textFieldText: sender.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
        self.disableSaveButton()
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        categoriesTable.layer.borderColor = UIColor.lightGray.cgColor
        categoriesTable.layer.borderWidth = 1.0
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
        showPlaceholder(in: categoriesTable, with: R.string.localizable.noCategoriesPlaceholcer())
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
    
    @objc func saveChanges() {
        presenter.saveChanges()
    }
    
    func updateUI(url: String, title: String) {
        self.url.text = url
        self.feedTitle.text = title
        presenter.numberOfRowsInSection > 0 ?
            self.categoriesTable.reloadData() :
            self.showPlaceholder()
    }
}

extension AddEditFeedViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == url {
            presenter.textFieldShouldReturn(tag: textField.tag, textFieldText: textField.text)
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
        return presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.categoryCell, for: indexPath) else {
            assertionFailure("Unable to init Category cell")
            return UITableViewCell()
        }
        cell.textLabel?.text = presenter.titleForRowAt(indexPath: indexPath)
        return cell
    }
}
