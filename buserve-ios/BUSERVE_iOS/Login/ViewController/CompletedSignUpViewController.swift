//
//  CompletedSignUpViewController.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/27.
//

import UIKit

class CompletedSignUpViewController: UIViewController {

    // MARK: - Properties
    
    private var completedSignUpLabel = CompletedSignUpLabelView()
    private var completedSignUpImage = UIImageView(image: UIImage(named: "CompletedCheck"))
    private var completedSignUpButton = BottomButtonView(title: "확인")
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [completedSignUpImage, completedSignUpLabel, completedSignUpButton].forEach { view.addSubview($0) }
        
        completedSignUpImage.translatesAutoresizingMaskIntoConstraints = false
        completedSignUpLabel.translatesAutoresizingMaskIntoConstraints = false
        completedSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        configureConstraints()
        
        completedSignUpButton.addTarget(self, action: #selector(handleCompletedSignUpButtonTapped), for: .touchUpInside)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = .Background
    }
    
    // MARK: - layouts
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            completedSignUpImage.heightAnchor.constraint(equalToConstant: 163),
            completedSignUpImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 106),
            completedSignUpImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -106),
            completedSignUpImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 171),
            
            
            completedSignUpLabel.heightAnchor.constraint(equalToConstant: 100),
            completedSignUpLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 67),
            completedSignUpLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -67),
            completedSignUpLabel.topAnchor.constraint(equalTo: completedSignUpImage.bottomAnchor, constant: 40),
            completedSignUpLabel.bottomAnchor.constraint(equalTo: completedSignUpButton.topAnchor, constant: -182),
            
            
            completedSignUpButton.heightAnchor.constraint(equalToConstant: 46),
            completedSignUpButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            completedSignUpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            completedSignUpButton.topAnchor.constraint(equalTo: completedSignUpLabel.bottomAnchor, constant: 182),
            completedSignUpButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        ])
    }
    
    // MARK: - methods
    
    @objc func handleCompletedSignUpButtonTapped() {
        // TabBarViewController를 표시
        let tabBarVC = TabBarViewController()
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
