//
//  ViewController.swift
//  TabletennisScoreBoard
//
//  Created by 陳鋐洋 on 2021/8/2.
//

import UIKit

class ViewController: UIViewController {
    var count1 = 0
    var count2 = 0
    var board1 = 0
    var board2 = 0
    var totalCount = 0
    var playerDeuce: Bool = false  // true->p1 , false->p2
    var stepList = [Tabletennis]()

    
    @IBOutlet weak var tvServe2: UILabel!
    @IBOutlet weak var tvServe1: UILabel!
    @IBOutlet weak var tvBoard1: UILabel!
    @IBOutlet weak var tvBoard2: UILabel!
    @IBOutlet weak var tvScore1: UILabel!
    @IBOutlet weak var tvScore2: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initfunc()
        stepList.removeAll()
    }
    
    //上一步
    @IBAction func btRewind(_ sender: Any) {
        
        
        if stepList.isEmpty {
            self.view.showToast(text: "已回復到底")
            changeBackgroundColor()
        }else{
            // 刪掉最後一個
            stepList.removeLast()
            // 拿最後一個物件
            let step = stepList.last
            tvScore1.text = step?.score1 ?? "0"
            tvScore2.text = step?.score2 ?? "0"
            tvBoard1.text = step?.board1 ?? "0"
            tvBoard2.text = step?.board2 ?? "0"
            tvServe1.text = step?.serve1 ?? "Serve"
            tvServe2.text = step?.serve2 ?? ""
            count1 = step?.count1 ?? 0
            count2 = step?.count2 ?? 0
            board1 = step?.boad1 ?? 0
            board2 = step?.boad2 ?? 0
            totalCount = step?.totalcount ?? 0
            playerDeuce = step?.playerDeuce ?? false
            self.view.showToast(text: "已回復")
            changeBackgroundColor()
        }
    }
    
    @IBAction func btChangeSide(_ sender: Any) {
        let tmpScore1 = tvScore1.text
        let tmpScore2 = tvScore2.text
        let tmpBoard1 = tvBoard1.text
        let tmpBoard2 = tvBoard2.text
        let tmpServe1 = tvServe1.text
        let tmpServe2 = tvServe2.text
        let tmpcount1 = count1
        let tmpcount2 = count2
        
        tvScore1.text = tmpScore2
        tvScore2.text = tmpScore1
        tvBoard1.text = tmpBoard2
        tvBoard2.text = tmpBoard1
        tvServe1.text = tmpServe2
        tvServe2.text = tmpServe1
        count1 = tmpcount2
        count2 = tmpcount1
        
        changeBackgroundColor()
        
        //紀錄step
        let step = Tabletennis(score1: tvScore1.text!, score2: tvScore2.text!, board1: tvBoard1.text!, board2: tvBoard2.text!, serve1: tvServe1.text!, serve2: tvServe2.text!, count1: count1, count2: count2, boad1: board1, boad2: board2, totalcount: totalCount, playerDeuce: playerDeuce)
        stepList.append(step)
    }
    
    @IBAction func btReset(_ sender: Any) {
        initfunc()
        stepList.removeAll()
        self.view.showToast(text: "清空紀錄，重新開始！")
    }
    
    @IBAction func btScore1(_ sender: Any) {
        count1 += 1
        totalCount += 1
        tvScore1.text = "\(count1)"
        changeSreve(totalCount)
        print(totalCount)
        
        if playerDeuce {
            var diff = count1 - count2
            var absDiff = abs(diff)
            if absDiff == 2{
                self.view.showToast(text: "Side1 Win!")
                count1 = 0
                count2 = 0
                tvScore1.text = "0"
                tvScore2.text = "0"
                board1 += 1
                tvBoard1.text = "\(board1)"
                totalCount = 0
                playerDeuce = false
            }
        }else{
            // 判斷Deuce
            if tvScore1.text == tvScore2.text && count1 == 10 {
                playerDeuce = true
                self.view.showToast(text: "Deuce")
            }else{
                if (count1 == 11 && tvScore1.text != tvScore2.text){
                    self.view.showToast(text: "Side1 Win!")
                    count1 = 0
                    count2 = 0
                    tvScore1.text = "0"
                    tvScore2.text = "0"
                    board1 += 1
                    tvBoard1.text = "\(board1)"
                    totalCount = 0
                  
                }
            }
        }
        //紀錄step
        let step = Tabletennis(score1: tvScore1.text!, score2: tvScore2.text!, board1: tvBoard1.text!, board2: tvBoard2.text!, serve1: tvServe1.text!, serve2: tvServe2.text!, count1: count1, count2: count2, boad1: board1, boad2: board2, totalcount: totalCount, playerDeuce: playerDeuce)
        stepList.append(step)
        //tvScore1.isUserInteractionEnabled = false
    }
    
    @IBAction func btScore2(_ sender: Any) {
        count2 += 1
        totalCount += 1
        tvScore2.text = "\(count2)"
        changeSreve(totalCount)
        print(totalCount)
    
        if playerDeuce {
            var diff = count2 - count1
            var absDiff = abs(diff)
            if absDiff == 2{
            self.view.showToast(text: "Side2 Win!")
            count1 = 0
            count2 = 0
            tvScore1.text = "0"
            tvScore2.text = "0"
            board2 += 1
            tvBoard2.text = "\(board2)"
            totalCount = 0
            playerDeuce = false
            }
        }else{
        if tvScore1.text == tvScore2.text && count2 == 10 {
            playerDeuce = true
                self.view.showToast(text: "Deuce")
            }else{
            if (count2 == 11 && tvScore2.text != tvScore1.text){
                self.view.showToast(text: "Side2 Win!")
                count1 = 0
                count2 = 0
                tvScore1.text = "0"
                tvScore2.text = "0"
                board2 += 1
                tvBoard2.text = "\(board2)"
                totalCount = 0
            }
          }
        }
        //紀錄step
        let step = Tabletennis(score1: tvScore1.text!, score2: tvScore2.text!, board1: tvBoard1.text!, board2: tvBoard2.text!, serve1: tvServe1.text!, serve2: tvServe2.text!, count1: count1, count2: count2, boad1: board1, boad2: board2, totalcount: totalCount, playerDeuce: playerDeuce)
        stepList.append(step)
        //tvScore2.isUserInteractionEnabled = false
    }
    
    //初始化
    func initfunc(){
        view.backgroundColor = UIColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1)
        tvScore1.text = "0"
        tvScore2.text = "0"
        tvBoard1.text = "0"
        tvBoard2.text = "0"
        tvServe1.text = "Serve"
        tvServe2.text = ""
        
        count1 = 0
        count2 = 0
        board1 = 0
        board2 = 0
        totalCount = 0
        playerDeuce = false
        
        // 紀錄step
        let step = Tabletennis(score1: tvScore1.text!, score2: tvScore2.text!, board1: tvBoard1.text!, board2: tvBoard2.text!, serve1: tvServe1.text!, serve2: tvServe2.text!, count1: count1, count2: count2, boad1: board1, boad2: board2, totalcount: totalCount, playerDeuce: playerDeuce)
        // 存到陣列裡
        stepList.append(step)
    }
    
    func changeSreve(_ totalcount: Int){
        if totalCount % 2 == 0 {
            let tmp = tvServe1.text
            tvServe1.text = tvServe2.text
            tvServe2.text = tmp
            
            changeBackgroundColor()
        }else{
            changeBackgroundColor()
        }
    }
    
    func changeBackgroundColor(){
        if tvServe1.text == "Serve"{
            view.backgroundColor = UIColor(red: 0.3, green: 0.2, blue: 0.1, alpha: 1)
        }else{
            view.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 1)
        }
    }
    
//    func addStep(){
//        let step = Tabletennis(score1: tvScore1.text!, score2: tvScore2.text!, board1: tvBoard1.text!, board2: tvBoard2.text!, serve1: tvServe1.text!, serve2: tvServe2.text!, count1: count1, count2: count2, totalcount: totalCount, playerDeuce: playerDeuce)
//
//        stepList.append(step)
//    }
    
}
extension UIView {

    func showToast(text: String){
        
        self.hideToast()
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999 //tag：hideToast實用來判斷要remove哪個label
        
        let maxSize = CGSize(width: self.bounds.width - 40, height: self.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width{
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height{
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((self.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: self.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        self.addSubview(toastLb)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            toastLb.alpha = 0.0
        }) { (complete) in
            toastLb.removeFromSuperview()
        }
    }
    
    func hideToast(){
        for view in self.subviews{
            if view is UILabel , view.tag == 9999{
                view.removeFromSuperview()
            }
        }
    }
}


