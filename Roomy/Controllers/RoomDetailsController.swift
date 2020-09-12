//
//  RoomDetailController.swift
//  Roomy
//
//  Created by Ashraf on 3/12/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import UIKit

class RoomDetailsController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var discriptionDetails: UILabel!
    
    var image = [UIImage(named: "LivingRoom"), UIImage(named: "BedRoom"), UIImage(named: "Kitchen")]
    var details = ""
    var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image[0]
        discriptionDetails.text = details
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListOfRoomsController") as? ListOfRoomsController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func previousImageButtonTapped(_ sender: UIButton) {
        imageNumber -= 1

        if imageNumber < 0 {
            imageNumber = 2
        }

        imageView.image = image[imageNumber]
    }

    @IBAction func forwardImageButtonTapped(_ sender: UIButton) {
        imageNumber += 1

        if imageNumber > 2 {
            imageNumber = 0
        }

        imageView.image = image[imageNumber]
    }
}
