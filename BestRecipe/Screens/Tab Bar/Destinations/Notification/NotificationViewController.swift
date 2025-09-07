//
//  NotificationViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/22/25.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let maintenanceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        maintenanceLabel.text = "Under Maintenance 🛠️"
        maintenanceLabel.font = UIFont(name: AppFont.Regular, size: 20)
        maintenanceLabel.textColor = .neutral60
        view.addSubview(maintenanceLabel)
        maintenanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}
