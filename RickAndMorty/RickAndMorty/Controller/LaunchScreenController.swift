//
//  LaunchScreenController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 01/01/2024.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    private lazy var nameImage: UIImageView = {
        return createImageView(named: "logoImage", frame: CGRect(x: 45, y: 109, width: 303, height: 212))
    }()
    
    private lazy var logoImage: UIImageView = {
        return createImageView(named: "loadingImage", frame: CGRect(x: 45, y: 329, width: 300, height: 300))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animate()
        }
    }
    
    private func createImageView(named imageName: String, frame: CGRect) -> UIImageView {
        let element = UIImageView()
        element.image = UIImage(named: imageName)
        element.contentMode = .scaleAspectFit
        element.frame = frame
        return element
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        [nameImage, logoImage].forEach { view.addSubview($0) }
    }
    
    private func animate() {
        for _ in 0...2 {
            UIView.animate(withDuration: 4, delay: 0.0, options: .curveLinear, animations: {
                self.logoImage.transform = self.logoImage.transform.rotated(by: .pi)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let mainTabBarController = MainTabBarController()
            mainTabBarController.modalTransitionStyle = .crossDissolve
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true)
        }
    }
}
