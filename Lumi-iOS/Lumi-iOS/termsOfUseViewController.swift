//
//  termsOfUseViewController.swift
//  Lumi-iOS
//
//  Created by Martin Kuvandzhiev on 9/12/16.
//  Copyright © 2016 Rapid Development Crew. All rights reserved.
//

import UIKit

class termsOfUseViewController: UIViewController {
    @IBOutlet weak var termsOfUseWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "lumi-privacy", ofType: "pdf")
        let targetURL = URL(fileURLWithPath: path!)
        let request = URLRequest.init(url: targetURL)
        termsOfUseWebView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.termsAndConditionsOpened()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
