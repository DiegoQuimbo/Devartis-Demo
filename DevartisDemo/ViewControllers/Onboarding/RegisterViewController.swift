//
//  LoginViewController.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.isEnabled = false
        }
    }
    
    // Private vars
    private let _disposeBag = DisposeBag()
    private let _viewModel = RegisterViewModel()
    private enum RegisterSegue: String {
        case ShowMain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - IBActions
    @IBAction func registerActionButton(_ sender: Any) {
        guard let user = userTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "There is an error with the data that you enter")
            return
        }
        
        showProgressHud(view: view)
        if _viewModel.userHasRegistered() {
            callLoginService(user: user, password: password)
        } else {
            callRegisterService(user: user, password: password)
        }
    }
}

// MARK: - Private Functions
private extension RegisterViewController {
    
    func setupView() {
        // By default the view is loaded with the register UI, if the user has registered before show login UI
        if _viewModel.userHasRegistered() {
            changeViewToLoginUI()
        }
        // Config RX
        setUpTextChangeHandling()
    }
    
    func setUpTextChangeHandling() {
        // Valid fields to enable confirm button
        let userValid = userTextField
            .rx
            .text
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { !($0?.isEmpty ?? true) }
        
        let passwordValid = passwordTextField
            .rx
            .text
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { !($0?.isEmpty ?? true) }

        let everythingValid = Observable
            .combineLatest(userValid, passwordValid) {
                $0 && $1
        }

        everythingValid
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: _disposeBag)
    }
    
    func changeViewToLoginUI() {
        headerTitleLabel.text = "Login"
        registerButton.setTitle("Login", for: .normal)
    }
    
    func callRegisterService(user: String, password: String) {
        _viewModel.registerService(user: user, password: password) { [unowned self] success in
            hideProgressHud(view: view)
            if success {
                goToMainView()
            } else {
                showAlert(title: "Error", message: "There is an error with the register service")
            }
        }
    }
    
    func callLoginService(user: String, password: String) {
        _viewModel.loginService(user: user, password: password) { [unowned self] success in
            hideProgressHud(view: view)
            if success {
                goToMainView()
            } else {
                showAlert(title: "Error", message: "There is an error with the login service")
            }
        }
    }
    
    func goToMainView() {
        performSegue(withIdentifier: RegisterSegue.ShowMain.rawValue, sender: nil)
    }
}
