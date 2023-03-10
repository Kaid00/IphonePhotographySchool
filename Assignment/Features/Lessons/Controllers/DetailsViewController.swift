//
//  MyView.swift
//  Assignment
//
//  Created by Azamah Junior Khan on 18/01/2023.
//

import UIKit

class Details: UIView {
    
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "The Key To Success In iPhone Photography"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "What’s the secret to taking truly incredible iPhone photos? Learning how to use your iPhone camera is very important, but there’s something even more fundamental to iPhone photography that will help you take the photos of your dreams! Watch this video to learn some unique photography techniques and to discover your own key to success in iPhone photography!"
        label.textAlignment = .natural
    
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "background")
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    
        configureConstraints()

    }
    
    
    func configureConstraints() {

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ]

        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
        
    }

    public func configure(with model: LessonObj) {
        titleLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init")
    }
}
