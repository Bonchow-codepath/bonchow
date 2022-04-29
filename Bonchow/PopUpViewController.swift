//
//  PopUpViewController.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/27.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var JoinView: UIView!
    @IBOutlet weak var resName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        // Do any additional setup after loading the view.
    }
    
    func configureView(){
        popUpView.layer.cornerRadius = 6
        JoinView.layer.cornerRadius = 6
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    @objc func dismissView(){
            self.dismiss(animated: false, completion: nil)
        }
    
    @IBAction func OnCancal(_ sender: Any) {
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
