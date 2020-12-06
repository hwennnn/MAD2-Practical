//
//  QRGeneratorController.swift
//  QRCode
//
//  Created by hwen on 5/12/20.
//

import Foundation
import UIKit
import QRCoder
import AVFoundation
import QRCodeReader

class QRGeneratorController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var QRText: UITextField!
    let generator = QRCodeGenerator()
    
    weak var delegate : QRCodeReaderViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        QRText.delegate = self
        
        //Default correction level is M
        generator.correctionLevel = .H
        QRImage.image = generator.createImage(value: QRText.text! ,size: CGSize(width: 200,height: 200))!
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        QRText.resignFirstResponder()
        QRImage.image = generator.createImage(value: QRText.text! ,size: CGSize(width: 200,height: 200))!
        return true
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        QRImage.image = generator.createImage(value: QRText.text! ,size: CGSize(width: 200,height: 200))!
        self.view.endEditing(true)
    }
}
