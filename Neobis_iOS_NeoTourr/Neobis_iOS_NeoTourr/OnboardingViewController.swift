//
//  OnboardingScreenView.swift
//  Neobis_iOS_NeoTour
//
//  Created by Yo on 22/2/24.
//

import Foundation
import SnapKit
import UIKit

class OnboardingScreenView: UIViewController {
    
    let viewImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboarding")
        image.layer.cornerRadius = 37
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Winter Vacation Trips"
        label.font = UIFont(name: "SFProDisplay-Black", size: 36)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Enjoy your winter vacations with warmth
        and amazing sightseeing on the mountains.
        Enjoy the best experience with us!
        """
        label.textAlignment = .left
        label.numberOfLines = 0
        
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 106/255, green: 98/255, blue: 184/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 26
        let buttonTitle = "Let's Go!"
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        button.setTitle(buttonTitle, for: .normal)
        button.contentVerticalAlignment = .center
        let image = UIImage(named: "go")
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupTarget()
    }
    
    private func setupViews() {
        view.addSubview(viewImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        viewImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(283)
            make.height.greaterThanOrEqualTo(86)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(16)
            make.height.greaterThanOrEqualTo(78)
            make.width.equalTo(289)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-115)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(177)
            make.height.equalTo(53)
        }
    }
    
    private func setupTarget() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
