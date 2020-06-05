//
//  PositionViewPortraitController.swift
//  Barven_Sport
//
//  Created by Nguyễn Minh Hiếu on 6/5/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class PositionViewPortraitController: UIViewController {

      var draggedViewFrame: CGRect?

        @IBOutlet weak var playerView: UIView!
        @IBOutlet weak var formationView: UIScrollView!
        @IBOutlet weak var maigure: UIStackView!
        @IBOutlet weak var shaw: UIStackView!
        @IBOutlet weak var pogba: UIStackView!
        @IBOutlet weak var bruno: UIStackView!
        @IBOutlet weak var martial: UIStackView!
        @IBOutlet weak var baily: UIStackView!
        @IBOutlet weak var bisaka: UIStackView!
        @IBOutlet weak var mctominay: UIStackView!
        @IBOutlet weak var greenwood: UIStackView!
        @IBOutlet weak var rashford: UIStackView!
        @IBOutlet weak var degea: UIStackView!
        
        var playerViews = [UIStackView]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            playerView.layer.cornerRadius = 8
            formationView.layer.cornerRadius = 8
            
            createPlayerViews()
            
            for view in playerViews {
                let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(draggingHandle))
                view.addGestureRecognizer(gestureRecognizer)
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }

        private func createPlayerViews() {
            playerViews.append(degea)
            playerViews.append(shaw)
            playerViews.append(maigure)
            playerViews.append(baily)
            playerViews.append(bisaka)
            playerViews.append(pogba)
            playerViews.append(mctominay)
            playerViews.append(rashford)
            playerViews.append(bruno)
            playerViews.append(greenwood)
            playerViews.append(martial)
        }
        
        @objc func draggingHandle(_ sender: UIPanGestureRecognizer) {
            
            //set bounds
            if let senderView = sender.view {
                if senderView.frame.origin.x < 0.0 {
                    senderView.frame.origin = CGPoint(x: 0.0, y: senderView.frame.origin.y)
                }
                if senderView.frame.origin.y < 0.0 {
                    senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: 0.0)
                }
                if senderView.frame.origin.x + senderView.frame.size.width > playerView.frame.width {
                    senderView.frame.origin = CGPoint(x: playerView.frame.width - senderView.frame.size.width, y: senderView.frame.origin.y)
                }
                if senderView.frame.origin.y + senderView.frame.size.height > playerView.frame.height {
                    senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: playerView.frame.height - senderView.frame.size.height)
                }
            }
            //
            
            if sender.state == .began {
                sender.view?.alpha = 0.5
                draggedViewFrame = sender.view?.frame
            } else if sender.state == .changed {
                let translation = sender.translation(in: playerView)
                guard let gestureView = sender.view else {
                    return
                }
                gestureView.center = CGPoint(x: gestureView.center.x + translation.x, y: gestureView.center.y + translation.y)
                sender.setTranslation(.zero, in: playerView)
                
                let draggingViewX = sender.location(in: playerView).x
                let draggingViewY = sender.location(in: playerView).y
                
                for secondView in playerViews {
                    
                    //
                    print("gestureView:\(gestureView.frame) + secondView:\(secondView.frame)")
    //                if gestureView.frame.origin.x > secondView.frame.origin.x && gestureView.frame.origin.y > secondView.frame.origin.y && gestureView.frame.origin.x + gestureView.frame.width < secondView.frame.width && gestureView.frame.origin.y + gestureView.frame.height < secondView.frame.height {
    //                    secondView.alpha = 0.5
    //                }
                    //
                    
                    if secondView.frame.origin.x <= draggingViewX && draggingViewX <= secondView.frame.origin.x + secondView.frame.width && secondView.frame.origin.y <= draggingViewY && draggingViewY <= secondView.frame.origin.y + secondView.frame.height {
                        secondView.alpha = 0.5

                    } else {
                        secondView.alpha = 1
                    }
                }
                
                        
            } else if sender.state == .ended {
                
                let draggingViewX = sender.location(in: playerView).x
                let draggingViewY = sender.location(in: playerView).y
                
                for secondView in playerViews {
                    if secondView.frame.origin.x <= draggingViewX && draggingViewX <= secondView.frame.origin.x + secondView.frame.width && secondView.frame.origin.y <= draggingViewY && draggingViewY <= secondView.frame.origin.y + secondView.frame.height {
                        secondView.alpha = 1
                        
                        let tempX = secondView.frame.origin.x
                        let tempY = secondView.frame.origin.y
                        let tempHeight = secondView.frame.size.height
                        let tempWidth = secondView.frame.size.width
                        
                        
                        guard let draggingViewFrame = draggedViewFrame else {
                            return
                        }
                        guard let draggingView = sender.view else {
                            return
                        }
                        
                        UIView.animate(withDuration: 0.2) {
                            secondView.frame = CGRect(x: draggingViewFrame.origin.x, y: draggingViewFrame.origin.y, width: draggingViewFrame.width, height: draggingViewFrame.height)
                            draggingView.frame = CGRect(x: tempX, y: tempY, width: tempWidth, height: tempHeight)
                        }
                    } else {
                        secondView.alpha = 1
                        sender.view?.alpha = 1
                    }
                }
            }
        }

}
