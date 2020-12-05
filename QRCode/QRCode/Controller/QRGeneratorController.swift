//
//  QRGeneratorController.swift
//  QRCode
//
//  Created by hwen on 5/12/20.
//

import Foundation
import UIKit
import QRCoder

class QRGeneratorController: UIViewController {
    
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var QRText: UITextField!
    let generator = QRCodeGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Default correction level is M
        generator.correctionLevel = .H
        QRImage.image = generator.createImage(value: QRText.text! ,size: CGSize(width: 200,height: 200))!
        
    }
    
    
    @IBAction func generateQR(_ sender: Any) {
        QRImage.image = generator.createImage(value: QRText.text! ,size: CGSize(width: 200,height: 200))!
    }
    
}
