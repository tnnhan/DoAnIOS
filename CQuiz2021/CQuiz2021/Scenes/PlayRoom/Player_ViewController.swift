//
//  Player_ViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/23/21.
//

import UIKit

class Player_ViewController: Base_ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbvPlayer: UITableView!
    
    var playerArr:[Player] = []
    var txtPin:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbvPlayer.delegate = self
        self.tbvPlayer.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.goToConnectServer()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvPlayer.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! Player_TableViewCell
        cell.lblNickName.text = "Tran Ngoc Nhan \(indexPath.row)"
        cell.imgAvatar.image = UIImage(named: "user")
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
