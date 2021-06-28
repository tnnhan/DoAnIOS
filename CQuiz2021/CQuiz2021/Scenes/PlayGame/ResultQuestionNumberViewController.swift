//
//  ResultQuestionNumberViewController.swift
//  CQuiz2021
//
//  Created by cuscsoftware on 6/28/21.
//

import UIKit

class ResultQuestionNumberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tbvDanhSachDiem: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.tbvDanhSachDiem.delegate = self
        self.tbvDanhSachDiem.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbvDanhSachDiem.dequeueReusableCell(withIdentifier: "ResultQuestionNumberTableViewCell", for: indexPath) as! ResultQuestionNumberTableViewCell
        cell.lblName.text = "thái thiên tân"
        cell.lblDiem.text = "0"
        return cell
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
