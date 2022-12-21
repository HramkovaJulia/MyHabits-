//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Artyom Prima on 02.11.2022.
//

import UIKit
//InfoViewController информация о привычках
class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1)
        shadowSettings()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(viewV)
        viewV.addSubview(labelTop)
        viewV.addSubview(labelInformation)
        
        setConstraints()
    }
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let viewV: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    private var labelTop: UILabel = {
        let labelTop = UILabel()
        labelTop.numberOfLines = 1
        labelTop.translatesAutoresizingMaskIntoConstraints = false
        labelTop.text = "Привычка за 21 день"
        labelTop.font = UIFont.boldSystemFont(ofSize: 20)
        return labelTop
    }()
    
    private var labelInformation: UILabel = {
        let labelInformation = UILabel()
        labelInformation.numberOfLines = 0
        labelInformation.sizeToFit()
        labelInformation.translatesAutoresizingMaskIntoConstraints = false
        labelInformation.font = UIFont(name: "systemFont", size: 20)
        labelInformation.text = """

   Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму

1. Провести 1 день без обращения\nк старым привычкам, стараться вести себя так, как будто цель, загаданная\nв перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3.  Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,\nс чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. \nЗа это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

"""
        return labelInformation
    }()
    
    func shadowSettings() {
        self.title = "Информация"
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 1
    }
    
    func setConstraints() {
        labelTop.topAnchor.constraint(equalTo: viewV.topAnchor, constant: 16).isActive = true
        labelTop.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelTop.leftAnchor.constraint(equalTo: viewV.leftAnchor, constant: 16).isActive = true
        labelTop.rightAnchor.constraint(equalTo: viewV.rightAnchor, constant: -16).isActive = true
        labelTop.bottomAnchor.constraint(equalTo: labelInformation.topAnchor).isActive = true
        
        labelInformation.topAnchor.constraint(equalTo: labelTop.bottomAnchor).isActive = true
        labelInformation.leftAnchor.constraint(equalTo: viewV.leftAnchor, constant: 16).isActive = true
        labelInformation.rightAnchor.constraint(equalTo: viewV.rightAnchor, constant: -16).isActive = true
        labelInformation.bottomAnchor.constraint(equalTo: viewV.bottomAnchor).isActive = true
        
        scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let sCLG = scrollView.contentLayoutGuide
        let fLG = scrollView.frameLayoutGuide
        
        viewV.leftAnchor.constraint(equalTo: sCLG.leftAnchor).isActive = true
        viewV.topAnchor.constraint(equalTo: sCLG.topAnchor).isActive = true
        viewV.rightAnchor.constraint(equalTo: sCLG.rightAnchor).isActive = true
        viewV.bottomAnchor.constraint(equalTo: sCLG.bottomAnchor).isActive = true
        
        viewV.leftAnchor.constraint(equalTo: fLG.leftAnchor).isActive = true
        viewV.rightAnchor.constraint(equalTo: fLG.rightAnchor).isActive = true
    }
}











