//
//  DocumentsController.swift
//  DocumentsApp
//
//  Created by Евгения Шевякова on 06.09.2023.
//

import UIKit

class DocumentsController: UITableViewController {
    
    var model: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = Model(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }

    @IBAction func addPhotoAction(_ sender: Any) {
        showImagePickerController()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = model?.items[indexPath.row]
        
        cell.contentConfiguration = configuration

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            model?.deleteItem(withIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}

// MARK: - Extensions

extension DocumentsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            model?.addImage(image: image)
        }

        dismiss(animated: true)
        tableView.reloadData()
    }
}
