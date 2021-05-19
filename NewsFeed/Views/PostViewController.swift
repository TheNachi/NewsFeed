//
//  PostViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import UIKit

class PostViewController: BaseViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        urlTextField.becomeFirstResponder()
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
