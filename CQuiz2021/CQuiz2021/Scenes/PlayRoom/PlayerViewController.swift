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
    
    @IBOutlet weak var lblPlayerList: UILabel!
    
    let manager = SocketManager(socketURL: URL(string: AppConstant.baseHost)!, config: [.log(true), .compress])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let socket = manager.defaultSocket
        socket.connect()
        socket.on("S_Sendto_C") {
            data, ack in
            print("Nhan du lieu:  \(data)")
            
//            if let arr = data as? [[String: Any]] {
//                if let txt = arr[0]["text"] as? String {
//                    print(txt)
//                }
//            }
//            let data = data else { return }
//
//            let jsonDecoder = JSONDecoder()
//            let listPalyers = try? jsonDecoder.decode(Player.self, from: data)
//
//            self.playerArr = listPalyers!.PlayerList
//
//            DispatchQueue.main.async {
//                self.tblPlayer.reloadData()
//            }
            
        }
        tblPlayer.dataSource = self
        tblPlayer.delegate = self
        lblPlayerList.text = "DANH SÁCH NGƯỜI CHƠI"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tblPlayer.dequeueReusableCell(withIdentifier: "PLAYER_CELL") as? Player_TableViewCell
        playerCell?.lblNickName.text = playerArr[indexPath.row].player_nickname
        return playerCell!
    }
    
    func goToConnectServer(){
        let socket = manager.defaultSocket
//        socket.on("connect") { data, ack in
//            socket.emit("C_AddGroup_S", ["setq_pin":self.txtPin.text!])
//        }
//        socket.on("S_SendPlayerList_C") { [self] data, ack in
//            var playerClassList:[Player] = []
//            let nSArray = data as NSArray
//            for item in (nSArray[0] as! NSArray) {
//                let disArray = item as! NSDictionary
//                let player =  Player(player_nickname: disArray["player_nickname"] as! String, setq_id: disArray["setq_id"] as! String,  player_avatar: disArray["player_avatar"] as! String, player_flag:disArray["player_flag"] as! String)
//                playerClassList.append(player)
//
//            }
//            let playerSb = self.sb.instantiateViewController(withIdentifier: "PLAYER") as? PlayerViewController
//            playerSb?.playerArr = playerClassList
//            self.navigationController?.pushViewController(playerSb!, animated: true)
//        }
        socket.connect()
    }

}
