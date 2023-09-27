//
//  AboutViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 22/04/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//1


import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var designedByLabel: UILabel!
    @IBOutlet weak var programmerLabel: UILabel!
    @IBOutlet weak var tapScreenLabel: UILabel!
    
   
    @IBOutlet weak var appNameConsCenterX: NSLayoutConstraint!
    @IBOutlet weak var designedByCOnsCenterX: NSLayoutConstraint!
    @IBOutlet weak var programmerConsCenterX: NSLayoutConstraint!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createParticles()
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
        setupInitialValues()
        
    }
    
    func setupInitialValues(){
        appNameConsCenterX.constant -= view.frame.width
        designedByCOnsCenterX.constant -= view.frame.height
        programmerConsCenterX.constant += view.frame.width
        tapScreenLabel.alpha = 0
        view.isUserInteractionEnabled = false
        let a:CGFloat = 31
        let b:CGFloat = 30
        let c:CGFloat = 17
        
        appNameLabel.font = UIFont(name: "Palatino", size: a.setSizeByWidth())
        designedByLabel.font = UIFont(name: "Palatino", size: c.setSizeByWidth())
        programmerLabel.font =
            UIFont(name: "Palatino", size: b.setSizeByWidth())
        
        tapScreenLabel.font = UIFont(name: "Palatino", size: c.setSizeByWidth())
        self.view.layoutIfNeeded()
    }
    
    func animations() {
        UIView.animateKeyframes(withDuration: 4, delay: 0.0,options:[], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.appNameConsCenterX.constant += self.view.frame.width
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                self.designedByCOnsCenterX.constant += self.view.frame.height
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.75) {
                self.programmerConsCenterX.constant -= self.view.frame.width
                self.view.layoutIfNeeded()
            }
            
        }) { _ in
            
            UIView.transition(with: self.tapScreenLabel, duration: 0.5, options: [.repeat,.autoreverse,.curveEaseOut], animations: {
                self.tapScreenLabel.alpha = 1
                self.view.isUserInteractionEnabled = true
            }, completion: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        animations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func handleTap(_ gesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let gray = makeEmitterCell(color: UIColor.gray)
        let lightGray = makeEmitterCell(color: UIColor.lightGray)
        let white = makeEmitterCell(color: UIColor.white)
        
        particleEmitter.emitterCells = [gray,lightGray,white]
        view.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 20
        cell.color = color.cgColor
        cell.velocity = 25
        cell.velocityRange = 100
        cell.emissionLongitude = 180 * (.pi / 180)
        cell.emissionRange = 45 * (.pi / 180)
        cell.spin = 0.2
        cell.scale = 0.2
        cell.spinRange = 0.4
        cell.scaleRange = 0.2
        cell.contents = UIImage(named: "snow")?.cgImage
        return cell
    }
        
    }
