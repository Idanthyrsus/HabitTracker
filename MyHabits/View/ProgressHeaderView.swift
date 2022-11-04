//
//  CustomCollectionViewCell.swift
//  MyHabits
//
//  Created by Alexander Korchak on 27.10.2022.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    
    static let identifier = "ProgressCellId"
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.layer.cornerRadius = 30
        progress.tintColor = UIColor(named: "Purple")
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = .lightGray
        return progress
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupElements()
    }
    
    private func setupElements() {
        self.addSubview(progressView)
        self.addSubview(progressLabel)
        self.addSubview(percentLabel)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 5),
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            progressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            progressLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -5),
            progressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            percentLabel.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 218),
            percentLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    func setupProgress(with value: Float) {
        self.percentLabel.text = "\(Int(value) * 100)%"
        self.progressView.setProgress(value, animated: true)
    }
}
