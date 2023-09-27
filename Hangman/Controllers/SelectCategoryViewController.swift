//
//  SelectCategoryViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    @IBOutlet weak var alertView: CustomView!
    @IBOutlet weak var SelectDificulty: UILabel!
    @IBOutlet weak var easyButton: CustomButton!
    @IBOutlet weak var normalButton: CustomButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var consBetweenEasyAndNormal: NSLayoutConstraint!
    @IBOutlet weak var consNormalAndBottomAlert: NSLayoutConstraint!
    @IBOutlet weak var consCloseTOTOp: NSLayoutConstraint!
    @IBOutlet weak var consCloseTORight: NSLayoutConstraint!
    @IBOutlet weak var consCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var closeButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var closeButtonHeight: NSLayoutConstraint!
    
    private var categoryListViewModel: SelectCategoryListViewModel!
    private var selectedCategory: SelectCategoryViewModel!
    
    private let cellIdentifier = "CategoryCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONService().loadJson { (categories) in
            self.categoryListViewModel = SelectCategoryListViewModel(categories)
            
        }
        
        let titleFontSize:CGFloat = 20
        
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleFontSize.setNavFontSize(), weight: UIFont.Weight.semibold)]
        
        let borderWidth:CGFloat = 2
        alertView.borderWidth = borderWidth.setSizeByHeight()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAlert(alert: .hide)
        
        let g:CGFloat = 18
        SelectDificulty.font = UIFont(name: "Roboto-Bold", size: g.setSizeByWidth())
        easyButton.titleLabel?.font = UIFont(name: "Roboto-BoldItalic", size: g.setSizeByWidth())
        normalButton.titleLabel?.font = UIFont(name: "Roboto-BoldItalic", size: g.setSizeByWidth())
        
        let spaceEasyNormal:CGFloat = 18
        consBetweenEasyAndNormal.constant = spaceEasyNormal.setSizeByHeight()
        
        let spaceNormalBottom:CGFloat = 20
        consNormalAndBottomAlert.constant = spaceNormalBottom.setSizeByWidth()
        
        let spaceCloseToSides:CGFloat = 10
        
        consCloseTOTOp.constant = spaceCloseToSides.setSizeByWidth()
        
        consCloseTORight.constant = spaceCloseToSides.setSizeByWidth()
        
        let closeButtonSize:CGFloat = 25
        
        closeButtonWidth.constant = closeButtonSize.setSizeByHeight()
        closeButtonHeight.constant = closeButtonSize.setSizeByHeight()
        
    }
    
    
    
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func easyButtonClicked(_ sender: Any) {
        let easyMode = EasyGameViewModel(selectCategoryVM: self.selectedCategory)
        self.performSegue(withIdentifier: "toGame", sender: easyMode)
    }
    
    @IBAction func normalBUttonCLicked(_ sender: Any) {
        let normalMode = NormalGameViewModel(selectCategoryVM: self.selectedCategory)
        self.performSegue(withIdentifier: "toGame", sender: normalMode)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toGame" else { return }
        guard let gameVC = segue.destination as? GameViewController else { return }
        
        if let mode = sender as? Strategy {
            mode.delegate = gameVC
            gameVC.vm = mode
        }
        
//        else if let mode = sender as? EasyGameViewModel {
//            mode.delegate = gameVC
//            gameVC.vm = mode
//        }
        
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        setupAlert(alert: .hide)
    }
    
    private enum Alert {
        case show
        case hide
    }
    
    private func setupAlert(alert:Alert) {
        
        switch alert {
        case .show:
            UIView.animate(withDuration: 0.5) {
                self.alertView.isHidden = false
                self.alertView.alpha = 1
                self.collectionView.alpha = 0.4
            }
            collectionView.isUserInteractionEnabled = false
            
        case .hide:
            
            UIView.animateKeyframes(withDuration: 0.0, delay: 0, options: []) {
                self.alertView.alpha = 0
                self.collectionView.alpha = 1
            } completion: { _ in
                self.collectionView.isUserInteractionEnabled = true
                self.alertView.isHidden = true
            }
            
            
        }
        
    }
    
    
}

// MARK: - UICollectionViewDataSource

extension SelectCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryListViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionCell
        let category = categoryListViewModel.getCategory(at: indexPath.row)
        
        cell.imageView.image = category.categoryImage
        let g:CGFloat = 15.5
        cell.title.font = UIFont(name: "Roboto-Regular", size: g.setSizeByWidth())
        cell.title.text = category.categoryName
        
        
        return cell
    }
    
}

extension SelectCategoryViewController: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategory = categoryListViewModel.getCategory(at: indexPath.row)
        
        setupAlert(alert: .show)
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SelectCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 0
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let yourHeight = collectionView.bounds.height / 5.0 - 10
            let yourWidth = collectionView.bounds.width / 3.0 - 10
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else {
            let yourHeight = collectionView.bounds.height / 6.0 - 10
            let yourWidth = collectionView.bounds.width / 3.0 - 10
            return CGSize(width: yourWidth, height: yourHeight)
        }
    }
    
}
