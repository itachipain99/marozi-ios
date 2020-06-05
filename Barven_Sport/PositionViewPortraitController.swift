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
          
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
            
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
                  
                  for secondView in playerViews {
                      if secondView.frame.intersects(gestureView.frame) {
                          secondView.alpha = 0.5
                      } else {
                          secondView.alpha = 1
                      }
                  }
                  
                          
              } else if sender.state == .ended {
                  
                  guard let gestureView = sender.view else {
                      return
                  }
                  
                  for secondView in playerViews {
                      if (secondView.frame.intersects(gestureView.frame)) {
                          secondView.alpha = 1
                          
                          let tempX = secondView.frame.origin.x
                          let tempY = secondView.frame.origin.y
                          let tempHeight = secondView.frame.size.height
                          let tempWidth = secondView.frame.size.width
                          
                          
                          guard let draggingViewFrame = draggedViewFrame else {
                              return
                          }
                          
                          UIView.animate(withDuration: 0.2) {
                              secondView.frame = CGRect(x: draggingViewFrame.origin.x, y: draggingViewFrame.origin.y, width: draggingViewFrame.width, height: draggingViewFrame.height)
                              gestureView.frame = CGRect(x: tempX, y: tempY, width: tempWidth, height: tempHeight)
                          }
                      } else {
                          secondView.alpha = 1
                          gestureView.alpha = 1
                      }
                      //back to previous position
                      if let senderView = sender.view {
                          if senderView.frame.origin.x < 0.0 {
                              backInView(subView: senderView, sender: sender)
                          }
                          if senderView.frame.origin.y < 0.0 {
                              backInView(subView: senderView, sender: sender)
                          }
                          if senderView.frame.origin.x + senderView.frame.size.width > playerView.frame.width {
                              backInView(subView: senderView, sender: sender)
                          }
                          if senderView.frame.origin.y + senderView.frame.size.height > playerView.frame.height {
                              backInView(subView: senderView, sender: sender)
                          }
                      }
                  }
              }
          }
      
      func backInView(subView: UIView, sender: UIPanGestureRecognizer) {
          guard let draggedViewFrame = draggedViewFrame else {
              return
          }
          UIView.animate(withDuration: 0.2) {
              subView.frame = draggedViewFrame
          }
          sender.state = .cancelled
          subView.alpha = 1
      }
}

@IBDesignable class PlayerImageView: UIImageView
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
