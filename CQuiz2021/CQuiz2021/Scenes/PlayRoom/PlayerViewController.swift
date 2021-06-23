//
//  PlayerViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 16/06/2021.
//

import UIKit

class PlayerViewController: Base_ViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblPlayer: UITableView!
    var playerArr:[Player] = []
    var txtPin:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPlayer.delegate = self
        tblPlayer.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goToConnectServer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tblPlayer.dequeueReusableCell(withIdentifier: "PLAYER_CELL", for: indexPath) as! Player_TableViewCell
        playerCell.lblNickName.text = "asa sasas sasa"// playerArr[indexPath.row].player_nickname
//        print(playerArr[indexPath.row].player_nickname)
        playerCell.imgAvatar.image = UIImage(named: "user")
//        //Color for last row
//        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
//        if indexPath.row == totalRows - 1 {
//            playerCell?.backgroundColor = UIColor.random
//        } else {
//            playerCell?.backgroundColor = UIColor.white
//        }
        return playerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func goToConnectServer(){
        let socket = manager.defaultSocket
        socket.on("connect") { data, ack in
            socket.emit("C_AddGroup_S", ["setq_pin":self.txtPin])
        }
        socket.on("S_SendPlayerList_C") { [self] data, ack in
            self.playerArr = []
            let nSArray = data as NSArray
            for item in (nSArray[0] as! NSArray) {
                let disArray = item as! NSDictionary
                let player =  Player(disArray["player_nickname"] as! String,disArray["setq_id"] as! String, disArray["player_avatar"] as! String, disArray["player_flag"] as! Int)
                playerArr.append(player)
                

            }
            print(playerArr)
            self.tblPlayer.reloadData()
            //prevent flickers
//            UIView.performWithoutAnimation {
//                self.tblPlayer.reloadData()
//                self.tblPlayer.beginUpdates()
//                self.tblPlayer.endUpdates()
//                DispatchQueue.main.async {
//                    let indexPath = IndexPath(row: self.playerArr.count-1, section: 0)
//                    self.tblPlayer.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                }
//            }
        }
        socket.connect()
    }

}

//extension UIColor {
//    static var random: UIColor {
//        srand48(Int(arc4random()))
//        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
//    }
//}
