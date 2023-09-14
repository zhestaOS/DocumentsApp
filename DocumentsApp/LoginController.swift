//
//  LoginController.swift
//  DocumentsApp
//
//  Created by Евгения Шевякова on 13.09.2023.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordButton: UIButton!
    
    let passwordManager = PasswordManager()
    
    private var firstStepPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordButton.setTitle(buttonTitle(), for: .normal)
    }
    
    func buttonTitle() -> String {
        passwordManager.isPasswordSaved() ? "Введите пароль" : "Создать пароль"
    }
    
    @IBAction func passwordButtonTapped(_ sender: Any) {
        if !passwordManager.isPasswordSaved() {
            createPasswordStepOne()
        } else {
            comparePassword()
        }
    }
    
    func createPasswordStepOne() {
        guard let password = passwordTextField.text else { return }
        guard password.count >= 4 else { return }
        
        passwordButton.setTitle("Повторите пароль", for: .normal)
        passwordButton.removeTarget(nil, action: nil, for: .allEvents)
        passwordButton.addTarget(self, action: #selector(createPasswordStepTwo), for: .touchUpInside)
        
        firstStepPassword = password
        passwordTextField.text = nil
    }
    
    @objc func createPasswordStepTwo() {
        guard let password = passwordTextField.text else {
            showError("Введите пароль повторно")
            return
        }
        guard password == firstStepPassword else {
            firstStepPassword = nil
            passwordTextField.text = nil
            
            showError("Пароли не совпадают")
            passwordButton.setTitle(buttonTitle(), for: .normal)
            passwordButton.removeTarget(nil, action: nil, for: .allEvents)
            passwordButton.addTarget(self, action: #selector(passwordButtonTapped), for: .touchUpInside)
            return
        }
        
        passwordManager.save(password)
        
        openMainApp()
    }
    
    func comparePassword() {
        guard let password = passwordTextField.text else { return }
        guard passwordManager.isPasswordCorrect(password) else {
            showError("Пароль введен не верно")
            passwordTextField.text = nil
            return
        }
        
        openMainApp()
    }
    
    private func showError(_ text: String)  {
        let action = UIAlertAction(title: "OK", style: .cancel)
        let controller = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        controller.addAction(action)
        present(controller, animated: true)
    }
    
    func openMainApp() {
        if navigationController != nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TabBarController")
            
            guard let navigationController = self.navigationController else { return }
            var navigationArray = navigationController.viewControllers
            navigationArray.remove(at: 0)
            self.navigationController?.viewControllers = navigationArray
            
            navigationController.pushViewController(vc, animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
}
