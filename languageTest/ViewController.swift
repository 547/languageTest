//
//  ViewController.swift
//  languageTest
//
//  Created by seven on 2019/2/27.
//  Copyright © 2019 seven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.text = LanguageTool.default.getValueWithKey("Welcome")
    }

    @IBAction func en(_ sender: Any) {
        LanguageTool.default.currentLanguage = .en
    }
    
    @IBAction func ch(_ sender: Any) {
        LanguageTool.default.currentLanguage = .ch
    }
    @IBAction func ch_HK(_ sender: Any) {
        LanguageTool.default.currentLanguage = .ch_hk
    }
}

