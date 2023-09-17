//
//  SettingsController.swift
//  DocumentsApp
//
//  Created by Евгения Шевякова on 13.09.2023.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet var alphabetSwitch: UISwitch!
    
    let passwordManager = PasswordManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alphabetSwitch.isOn = UserDefaults().bool(forKey: isSortToAlphabetical)
    }
    
    @IBAction func alphabetSwitchValueChanged(_ sender: Any) {
        UserDefaults().set(alphabetSwitch.isOn, forKey: isSortToAlphabetical)
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        passwordManager.remove()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginController")
        present(vc, animated: true)
    }
    
}
