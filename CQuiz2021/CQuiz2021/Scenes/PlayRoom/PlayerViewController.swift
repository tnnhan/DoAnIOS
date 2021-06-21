//
//  PlayerViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 16/06/2021.
//

import UIKit
import SocketIO

class PlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblPlayer: UITableView!
    var playerArr:[Player] = []
    var txtPin:String = ""
    @IBOutlet weak var lblPlayerList: UILabel!
    
    let manager = SocketManager(socketURL: URL(string: AppConstant.baseHost)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPlayer.dataSource = self
        tblPlayer.delegate = self
        lblPlayerList.text = "DANH SÁCH NGƯỜI CHƠI"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goToConnectServer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tblPlayer.dequeueReusableCell(withIdentifier: "PLAYER_CELL") as? Player_TableViewCell
        playerCell?.lblNickName.text = playerArr[indexPath.row].player_nickname
        playerCell?.imgAvatar.image = UIImage(named: "user")
//        //Color for last row
//        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
//        if indexPath.row == totalRows - 1 {
//            playerCell?.backgroundColor = UIColor.random
//        } else {
//            playerCell?.backgroundColor = UIColor.white
//        }
        return playerCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
                let player =  Player(player_nickname: disArray["player_nickname"] as! String, setq_id: disArray["setq_id"] as! String,  player_avatar: disArray["player_avatar"] as! String, player_flag:disArray["player_flag"] as! Int)
                playerArr.append(player)

            }
            print(playerArr)
           
            //prevent flickers
            UIView.performWithoutAnimation {
                self.tblPlayer.reloadData()
//                self.tblPlayer.beginUpdates()
//                self.tblPlayer.endUpdates()
//                DispatchQueue.main.async {
//                    let indexPath = IndexPath(row: self.playerArr.count-1, section: 0)
//                    self.tblPlayer.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                }
            }
        }
        socket.connect()
    }

}

extension UIColor {
    static var random: UIColor {
        srand48(Int(arc4random()))
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}
