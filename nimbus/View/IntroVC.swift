//
//  IntroVC.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  periclesm@cloudfields.net
//  Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//  https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit
import NVActivityIndicatorView

class IntroVC: UIViewController {

	@IBOutlet weak var actionButton: UIButton!
	@IBOutlet weak var actionIndicator: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.actionButton.isEnabled = false
		actionIndicator.type = .ballRotate
		actionIndicator.startAnimating()

		DataManager.prefetchData { (completed) in
			self.actionButton.isEnabled = true
			self.actionIndicator.stopAnimating()
		}
    }
}
