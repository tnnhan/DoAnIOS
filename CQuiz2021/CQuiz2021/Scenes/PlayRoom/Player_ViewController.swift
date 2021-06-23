//
//  Player_ViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/23/21.
//

import UIKit

class Player_ViewController: Base_ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbvPlayer: UITableView!
    @IBOutlet weak var lblRoomTitle: UILabel!
    @IBOutlet weak var lblPlayers: UILabel!
    
    var playerArr:[Player] = []
    var txtPin:String?
    var txtTitle:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbvPlayer.delegate = self
        self.tbvPlayer.dataSource = self
        lblRoomTitle.text = self.txtTitle
        navigationController?.navigationBar.backItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.goToConnectServer()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvPlayer.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! Player_TableViewCell
        cell.lblNickName.text = playerArr[indexPath.row].player_nickname
        cell.imgAvatar.image = UIImage(named: "user")
//        cell.imgAvatar.image = UIImage(named: playerArr[indexPath.row].player_avatar)
        
        //Color for last row
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == totalRows - 1 {
            cell.backgroundColor = UIColor.random
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    // MARK: - Socket
    
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
                let player =  Player(disArray["player_nickname"] as! String,disArray["setq_id"] as! String,disArray["player_avatar"] as! String,disArray["player_flag"] as! Int)
                playerArr.append(player)
            }
            lblPlayers.text = String(playerArr.count)
            //prevent flickers
            UIView.performWithoutAnimation {
                self.tbvPlayer.reloadData()
                self.tbvPlayer.beginUpdates()
                self.tbvPlayer.endUpdates()
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: self.playerArr.count-1, section: 0)
                    self.tbvPlayer.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
        socket.on("PlayGame") {data, ack in
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "PLAYGAME") as! PlayGame_ViewController
            self.navigationController?.pushViewController(vc, animated: true)
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
