//
//  ResultQuestionNumberViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import UIKit

class ResultQuestionNumberViewController: Base_ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tbvDanhSachDiem: UITableView!
    
    var resultQuestionArr:[ResultQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.tbvDanhSachDiem.delegate = self
        self.tbvDanhSachDiem.dataSource = self
        socketPlayGame()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultQuestionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvDanhSachDiem.dequeueReusableCell(withIdentifier: "ResultQuestionNumberTableViewCell", for: indexPath) as! ResultQuestionNumberTableViewCell
        if(indexPath.row == 0) {
            cell.imgMedal.image = UIImage(named: "gold-medal")
        } else if (indexPath.row == 1) {
            cell.imgMedal.image = UIImage(named: "silver-medal")
        } else if(indexPath.row == 2) {
            cell.imgMedal.image = UIImage(named: "bronze-medal")
        }
        cell.lblName.text = resultQuestionArr[indexPath.row].player_nickname
        cell.lblDiem.text = String(resultQuestionArr[indexPath.row].point)
        return cell
    }
    func socketPlayGame(){
        let socket = manager.defaultSocket
        socket.on("S_SendResultQuestionNumberBroadCast_C") { [self] data, ack in
            print("Result for Single question: \(data)")
            
            self.resultQuestionArr = []
            let nSArray = data as NSArray
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let resultQuestion = ResultQuestion(
                    disArray["player_id"] as! String,
                    disArray["player_nickname"] as! String,
                    disArray["point"] as! Int,
                    disArray["question_id"] as! String,
                    disArray["setq_id"] as! String)
                resultQuestionArr.append(resultQuestion)
            }
            tbvDanhSachDiem.reloadData()
        }
        socket.connect()
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
