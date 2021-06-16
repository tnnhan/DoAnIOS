//
//  ViewController.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 6/7/21.
//

import UIKit
import SocketIO
import SwiftyJSON

class ViewController: Base_ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    var isMale = false
    @IBOutlet weak var imgGender: UIImageView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var imgView: UIView!
    
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtPin: UITextField!
    
    let manager = SocketManager(socketURL: URL(string: AppConstant.baseHost)!, config: [.log(true), .compress])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
//        let socket = manager.defaultSocket
//        socket.connect()
//        socket.on("S_Sendto_C") {
//            data, ack in
//            print("Nhan du lieu:  \(data)")
//        }
    }
    
    func design() {
        btnUpload.layer.cornerRadius = 15
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width / 2
    }
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func selectGender(_ sender: UITapGestureRecognizer) {
        if(isMale == false) {
            imgGender.image = UIImage(named: "checkbox")
            isMale = true
        } else {
            imgGender.image = UIImage(named: "uncheckbox")
            isMale = false
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        DispatchQueue.main.async {
            let url = URL(string: AppConstant.joinUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            var sData = "player_nickname=" + self.txtNickName.text!
            sData += "&setq_pin=" + self.txtPin.text!
            
            let postData = sData.data(using: .utf8)
            request.httpBody = postData
            
            let joiningTask = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                guard error == nil else { print("error"); return }
                guard let data = data else { return }
                
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                    print(json["result"])
                    if( json["result"] as! Int == 1 ){
                        
                        
                        
//                        DispatchQueue.main.async {
//                            do{
//                                let imgData = try! Data(contentsOf: URL(string: urlHinh)!)
//                                self.img_Avatar.image = UIImage(data: imgData)
//                            }catch{}
//
//                            self.lbl_HoTen.text = user!["Name"] as? String
//                            self.lbl_Email.text = user!["Address"] as? String
                            
//                        }
                    }else{
                        print(json["result"])
//                        DispatchQueue.main.async {
//                            let alertView = UIAlertController(title: "Thong bao", message: (json["errMsg"] as! String), preferredStyle: .alert)
//                            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                            self.present(alertView, animated: true, completion: nil)
//                        }
                    }
                    
                }catch let error { print(error.localizedDescription) }
            })
            joiningTask.resume()
        }
        
        
        
//        let message = BaseService.uploadFile(urlStr: AppConstant.uploadAvatarUrl, dataFile: (imgAvatar.image?.pngData())!, fileName: "avatar")
//        displayAlert(title: "Thong bao", messg: "Thanh cong")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            imgAvatar.image = image
        }
        self.dismiss(animated: true, completion: nil  )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }

    func setGradientBackground() {
        let colorBottom  =  UIColor(red: 215.0/255.0, green: 236.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        let colorMedium = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 245.0/255.0, green: 213.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMedium, colorBottom]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}

