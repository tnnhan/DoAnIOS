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
        
        
        
        
        
        playerArr = [
           Player(_id: "1", setq_created_by: "Test", setq_description: "Test", setq_image: "Test", setq_title: "Test", setq_visibility: "Test")
        ]
        tblPlayer.dataSource = self
        tblPlayer.delegate = self
        lblPlayerList.text = "DANH SÁCH NGƯỜI CHƠI"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell = tblPlayer.dequeueReusableCell(withIdentifier: "PLAYER_CELL") as? Player_TableViewCell
        playerCell?.lblNickName.text = playerArr[indexPath.row].setq_description
        return playerCell!
    }

}
