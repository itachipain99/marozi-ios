//
//  PositionViewController.swift
//  Barven_Sport
//
//  Created by Nguyễn Minh Hiếu on 5/27/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {

    @IBOutlet weak var tacticalTableView: UITableView!
    
    var arrayTactical = ["4-4-2","4-2-3-1","4-1-4-1","4-3-3","4-2-2-2"]
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var left_view: CustomUIView!
    @IBOutlet weak var Soccer1: UIStackView!
    @IBOutlet weak var Soccer2: UIStackView!
    @IBOutlet weak var Soccer3: UIStackView!
    @IBOutlet weak var Soccer4: UIStackView!
    @IBOutlet weak var Soccer5: UIStackView!
    @IBOutlet weak var Soccer6: UIStackView!
    @IBOutlet weak var Soccer7: UIStackView!
    @IBOutlet weak var Soccer8: UIStackView!
    @IBOutlet weak var Soccer9: UIStackView!
    @IBOutlet weak var Soccer10: UIStackView!
    @IBOutlet weak var Soccer11: UIStackView!
    
    var sizePan : CGSize?
    var positTap : CGPoint?
    var checkItempPan = -1
    var arraySoccer = [Soccer]()
    var arraySize = [CGSize]()
    var Preposition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tacticalTableView.dataSource = self
        tacticalTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        arraySoccer = [Soccer(Soccer1),
                       Soccer(Soccer2),
                       Soccer(Soccer3),
                       Soccer(Soccer4),
                       Soccer(Soccer5),
                       Soccer(Soccer6),
                       Soccer(Soccer7),
                       Soccer(Soccer8),
                       Soccer(Soccer9),
                       Soccer(Soccer10),
                       Soccer(Soccer11),]
        arraySoccer.forEach { (soccer) in
            arraySize.append(soccer.name!.bounds.size)
        }
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    @IBAction func Pan_Soccer(_ sender: UIPanGestureRecognizer) {
        // POSITION WHEN TAP AND SIZE OF PANVIEW
        if sender.state == .began {
            sizePan = sender.view?.bounds.size
            positTap = sender.view?.frame.origin
            for i in 0..<11 {
                //false
                if arraySoccer[i].location!.contains(sender.view!.frame){
                    checkItempPan = i
                }
            }
        }
        let posit = sender.translation(in: left_view)
        // CROSS BODER
        if sender.view!.frame.origin.x <= 0  || sender.view!.frame.origin.x + sizePan!.width > left_view.bounds.width || sender.view!.frame.origin.y <= 0 || sender.view!.frame.origin.y + sizePan!.height > left_view.bounds.height {
            sender.state = .cancelled
            UIView.animate(withDuration: 0.2) {
                sender.view?.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            }
        }
        else {
            sender.view?.transform = (sender.view?.transform.translatedBy(x: posit.x, y: posit.y))!
            sender.view?.alpha = 1
        }
        sender.setTranslation(CGPoint.zero, in: left_view)
        
        if sender.state == .changed{
//            print("checkItemPan:",checkItempPan)
//            print("checkItem:",checkOverride(sender))
            
            if checkOverride(sender) != -1 {
                arraySoccer[checkOverride(sender)].name!.alpha = 0.2
            }
            
            if checkItempPan == checkOverride(sender){
//                checkItempPan = Preposition
                arraySoccer[checkOverride(sender)].name!.alpha = 1
            }
            
        }
        
        //CHECK SOCCER CHANGE
        if sender.state == .ended {
            sender.view?.alpha = 1
            if checkOverride(sender) != -1{
                swapSoccer(sender,checkOverride(sender), checkItempPan)
//                Preposition = checkItempPan
            }
            else {
                // fix ve chon vao vi tri cu the
                UIView.animate(withDuration: 0.2) {
                    sender.view?.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                }
            }
            arraySoccer.forEach { (soccer) in
                soccer.name!.alpha = 1
            }
        }
    
    }
    //CHECK OVERRIDE
    func checkOverride(_ pan : UIPanGestureRecognizer) -> Int{
        for i in 0..<11{
            if arraySoccer[i].location!.contains(pan.location(in: left_view)){
                return i
            }
        }
        return -1
    }
    var check = true
    //SWAP SOCCER
    func swapSoccer(_ pan : UIPanGestureRecognizer,_ n : Int,_ s : Int) {
        UIView.animate(withDuration: 0.5) {
            self.arraySoccer[n].name?.frame.origin = CGPoint(x: self.arraySoccer[s].center!.x - self.arraySize[n].width/2, y: self.arraySoccer[s].location!.origin.y)
            pan.view?.frame.origin = CGPoint(x: self.arraySoccer[n].center!.x - self.arraySize[s].width/2, y: self.arraySoccer[n].location!.origin.y)
        }
//        self.arraySoccer[s].name?.frame.origin = CGPoint(x: self.arraySoccer[n].center!.x - self.arraySize[s].width/2, y: self.arraySoccer[n].location!.origin.y)
        
        let a = arraySoccer[s].location
        arraySoccer[s].location = arraySoccer[n].location
        arraySoccer[n].location = a

        let b = arraySoccer[s].center
        arraySoccer[s].center = arraySoccer[n].center
        arraySoccer[n].center = b
//        print(arraySoccer[2].location)
//        print(arraySoccer[9].location)
    }
    
}

extension PositionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTactical.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TacticalTableViewCell") as? TacticalTableViewCell
        cell?.lbl_tactical.text = arrayTactical[indexPath.row]
        cell?.parentVC = self
        return cell!
    }

}

extension PositionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/5.5
    }

}
