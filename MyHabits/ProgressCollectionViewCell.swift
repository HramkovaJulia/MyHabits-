//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Artyom Prima on 04.11.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProgressCollectionViewCel"

    private var labelText: UILabel = {
        let labelText = UILabel()
        labelText.numberOfLines = 1
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.text = "Все получится!"
        labelText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        labelText.textColor = .systemGray2
       
  
        return labelText
    }()
    
    private var labelProcent: UILabel = {
        let labelProcent = UILabel()
        labelProcent.numberOfLines = 1
        labelProcent.translatesAutoresizingMaskIntoConstraints = false
//        labelProcent.text = "50%"
        labelProcent.textColor = .systemGray2
        labelProcent.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        return labelProcent
    }()
    
    let stackViewLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .scaleAspectFill
        stackView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = #colorLiteral(red: 0.6286723018, green: 0.08557639271, blue: 0.7971386313, alpha: 1)
        progressView.trackTintColor = .systemGray2
        progressView.layer.sublayers![0].cornerRadius = 3.5
        progressView.subviews[0].clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 3.5
        progressView.subviews[1].clipsToBounds = true
        progressView.progress = HabitsStore.shared.todayProgress
        
        return progressView
    }()
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        labelProcent.text = "\(Int(progressView.progress * 100))%"
        addSubview()
        setConstraints()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            stackViewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackViewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackViewLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
     
            progressView.topAnchor.constraint(equalTo: stackViewLabel.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func addSubview() {
        contentView.addSubview(progressView)
        contentView.addSubview(stackViewLabel)
        
        stackViewLabel.addArrangedSubview(labelText)
        stackViewLabel.addArrangedSubview(labelProcent)
    }
}
