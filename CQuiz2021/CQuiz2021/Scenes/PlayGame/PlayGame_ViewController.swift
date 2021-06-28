//
//  PlayGame_ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 23/06/2021.
//

import UIKit

class PlayGame_ViewController: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    @IBAction func tapA(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = false
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = true
    }
    
    @IBAction func tapB(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = false
        imageC.isHidden = true
        imageD.isHidden = true
    }
    
    @IBAction func tapC(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = false
        imageD.isHidden = true
    }
    
    @IBAction func tapD(_ sender: UITapGestureRecognizer) {
        imageA.isHidden = true
        imageB.isHidden = true
        imageC.isHidden = true
        imageD.isHidden = false
    }
    
}
