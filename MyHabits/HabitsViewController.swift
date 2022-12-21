//
//  ViewController.swift
//  MyHabits
//
//  Created by Artyom Prima on 02.11.2022.
//

import UIKit
// HabitsViewController отображает привычки
class HabitsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    weak var delegate1: TestDelegate?
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationSettings()
        setupCollectionview()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    private func setupCollectionview() {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        viewLayout.itemSize = CGSize(
            width: view.frame.size.width - 25,
            height: view.frame.size.width/4 )
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView?.backgroundColor = #colorLiteral(red: 0.9490192533, green: 0.9490200877, blue: 0.9662286639, alpha: 1)
        
        collectionView?.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier
        )
        
        collectionView?.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        collectionView?.dataSource = self
        collectionView?.delegate = self
        view.addSubview(collectionView!)
    }
    
    @objc func addTapped() {
        let habitVC = HabitViewController()
        habitVC.didAppendHabit = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.collectionView?.reloadData()
        }
        
        let navbar =  UINavigationController(rootViewController: habitVC)
        present(navbar, animated: true)
    }
    
    func navigationSettings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.title = "Сегодня"
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6329703331, green: 0.08420988172, blue: 0.8011942506, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Отменить")
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.6329703331, green: 0.08420988172, blue: 0.8011942506, alpha: 1)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 1
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return HabitsStore.shared.habits.count
        default:
            assertionFailure("no registered section")
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.identifier,
                for: indexPath) as? ProgressCollectionViewCell
            return cell!
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.habit = store.habits[indexPath.item]
            cell.delegateHabitCell = self
            
            return cell
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            var size = CGSize()
            size.width = (collectionView!.frame.width - 33)
            size.height = 60
            return size
        case 1:
            var size = CGSize()
            size.width = (collectionView!.frame.width - 33)
            size.height = 130
            return size
        default:
            return CGSize()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 22,
            left: 17,
            bottom: 16,
            right: 16
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
}

extension HabitsViewController: TestDelegate {
    func updCollection() {
        
        //        collectionView!.reloadData()
        //        collectionView!.reloadInputViews()
        //        print("Вызвался collectionView.reloadData()")
    }
}
