//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Artyom Prima on 04.11.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let store = HabitsStore.shared
    weak var delegateHabitCell: TestDelegate?
    
    static let identifier = "HabitCollectionViewCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .purple
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        addSubview()
        setConstraints()
        
    }
    
    private var nameOfTheHabit: UILabel = {
        let nameOfTheHabit = UILabel()
        nameOfTheHabit.numberOfLines = 1
        nameOfTheHabit.translatesAutoresizingMaskIntoConstraints = false
        nameOfTheHabit.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return nameOfTheHabit
    }()
    
    private var repeatingHabit: UILabel = {
        let repeatingHabit = UILabel()
        repeatingHabit.numberOfLines = 1
        repeatingHabit.translatesAutoresizingMaskIntoConstraints = false
        repeatingHabit.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        repeatingHabit.textColor = #colorLiteral(red: 0.6823526025, green: 0.6823533773, blue: 0.6995556951, alpha: 1)
        
        return repeatingHabit
    }()
    
    private var doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        doneButton.layer.cornerRadius =  19
        doneButton.clipsToBounds = true
        doneButton.layer.masksToBounds = true
        doneButton.layer.borderWidth = 1.0
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(buttonColorChoose), for: .touchUpInside)
        return doneButton
    }()
    
    private var countHabit: UILabel = {
        let countHabit = UILabel()
        countHabit.numberOfLines = 1
        countHabit.translatesAutoresizingMaskIntoConstraints = false
        countHabit.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        countHabit.text = "Счетчик: 0"
        countHabit.textColor = #colorLiteral(red: 0.5568622351, green: 0.5568631887, blue: 0.5783511996, alpha: 1)
        
        return countHabit
    }()
    
    var habit: Habit? {
        didSet{
            nameOfTheHabit.text = habit?.name
            nameOfTheHabit.textColor = habit?.color
            repeatingHabit.text = habit?.dateString
            doneButton.layer.borderColor  = habit?.color.cgColor
            countHabit.text = "Счетчик: \(habit?.trackDates.count ?? 0)"
            if ((habit?.isAlreadyTakenToday) == true) {
                doneButton.backgroundColor = nameOfTheHabit.textColor
                doneButton.setTitle("✓", for: .normal)
                       } else {
                        print("dddfdfd")
                       }
     
        }
    }
    var didAppendHabit: (() -> Void)?
    @objc func buttonColorChoose(){
        if habit?.isAlreadyTakenToday == false {
            doneButton.backgroundColor = nameOfTheHabit.textColor
            doneButton.setTitle("✓", for: .normal)
            HabitsStore.shared.track(habit!)
            didAppendHabit?()
          
        }else {
            print("crax")
        }
    }
    
    
    func addSubview() {
        contentView.addSubview(nameOfTheHabit)
        contentView.addSubview(repeatingHabit)
        contentView.addSubview(doneButton)
        contentView.addSubview(countHabit)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameOfTheHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameOfTheHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameOfTheHabit.bottomAnchor.constraint(equalTo: repeatingHabit.topAnchor, constant: -4),
            
            repeatingHabit.topAnchor.constraint(equalTo: nameOfTheHabit.bottomAnchor),
            repeatingHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            repeatingHabit.bottomAnchor.constraint(equalTo: countHabit.topAnchor, constant: 30),
            
            doneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            doneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            countHabit.topAnchor.constraint(equalTo: repeatingHabit.bottomAnchor),
            countHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    func config(habit: Habit ) {
        nameOfTheHabit.text = habit.name
        nameOfTheHabit.textColor = habit.color
        repeatingHabit.text = habit.dateString
        doneButton.layer.borderColor  = habit.color.cgColor
    }
    
}
