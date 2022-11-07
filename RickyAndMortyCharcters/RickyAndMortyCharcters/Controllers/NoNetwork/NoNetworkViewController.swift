//
//  NoNetworkViewController.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 03/11/22.
//

import UIKit

class NoNetworkViewController: UIViewController {

    let networkHandler = RAMNetworkHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkHandler.initiateNetworkStatusCheck { isConnected in
            if(isConnected) {
                self.dismiss(animated: true)
            } else {
                self.networkHandler.networkStatusChanged = { isConnected in
                    if(isConnected) {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                        
                    }
                }
            }
        }
        
    }
    
    
    
    @IBAction func retryTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
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
