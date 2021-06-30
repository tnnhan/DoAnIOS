//
//  PlayGame_ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 23/06/2021.
//

import UIKit

class PlayGame_ViewController: Base_ViewController {

    @IBOutlet weak var btnTraLoi: UIButton!
    @IBOutlet weak var txtCauHoi: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var lblQuestionD: UILabel!
    @IBOutlet weak var lblQuestionC: UILabel!
    @IBOutlet weak var lblQuestionB: UILabel!
    @IBOutlet weak var lblQuestionA: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var imageD: UIImageView!
    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var imageC: UIImageView!
    @IBOutlet weak var heightConstraintsImage: NSLayoutConstraint!
    
    var question:Question?
    var answerArr:[Answer] = []
    var time:Int = 0
    var dapAnChon:Int = 0
    var player_id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        lblQuestionD.layer.cornerRadius = 10
        lblQuestionD.layer.masksToBounds = true
        lblQuestionC.layer.cornerRadius = 10
        lblQuestionC.layer.masksToBounds = true
        lblQuestionB.layer.cornerRadius = 10
        lblQuestionB.layer.masksToBounds = true
        lblQuestionA.layer.cornerRadius = 10
        lblQuestionA.layer.masksToBounds = true
        btnTraLoi.layer.cornerRadius = 10
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        design()
        socketPlayGame()
    }
    
    func design(){
        self.txtCauHoi.text = question?.question_title
        var url = URL(string: AppConstant.getUrlImageQuestionUrl + "1622778560765-6A4F09FC-5D74-4B9A-B089-5F00704FDEFA.jpg")
        do{
            var data = try Data(contentsOf: url!)
            self.image.image = UIImage(data: data)
        }catch{
            
        }
        self.lblQuestionA.text = answerArr[0].answer_title
        self.lblQuestionB.text = answerArr[1].answer_title
        self.lblQuestionC.text = answerArr[2].answer_title
        self.lblQuestionD.text = answerArr[3].answer_title
        self.btnTraLoi.isHidden = true
    }
    
    @IBAction func tapA(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = false
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 0
    }
    
    @IBAction func tapB(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = false
        imageC.isHidden = true
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 1
    }
    
    @IBAction func tapC(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = false
        imageD.isHidden = true
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 2
    }
    
    @IBAction func tapD(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = false
        self.btnTraLoi.isHidden = false
        self.dapAnChon = 3
    }
    
    
    @IBAction func onAnswerAction(_ sender: UIButton) {
        let socket = manager.defaultSocket
        socket.emit("ResultQuestionNumber", ["player_id":self.player_id,
                                             "question_id":self.answerArr[self.dapAnChon].question_id,
                                             "setq_id":self.question?.setq_id,
                                             "point":self.time])
        self.btnTraLoi.isHidden = true
        socket.connect()
    }
    // MARK: - Socket
    
    func socketPlayGame(){
        let socket = manager.defaultSocket
        socket.on("S_SendResultQuestionNumber_C") { [self] data, ack in
            print("Result for Single question: \(data)")
            
            var resultArr:[ResultQuestion] = []
            let nSArray = data as NSArray
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let resultQuestion = ResultQuestion(
                    disArray["player_id"] as! String,
                    disArray["player_nickname"] as! String,
                    disArray["point"] as! Int,
                    disArray["question_id"] as! String,
                    disArray["setq_id"] as! String)
                resultArr.append(resultQuestion)
            }
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ResultQuestionNumberViewController") as! ResultQuestionNumberViewController
            vc.resultQuestionArr = resultArr
            self.navigationController?.pushViewController(vc, animated: true)
        }
        socket.on("CountDownQuestion") {data, ack in
            self.title = "Bạn còn \(data[0] as! Int) giây"
            self.time = data[0] as! Int
        }
        socket.connect()
    
    }
}
