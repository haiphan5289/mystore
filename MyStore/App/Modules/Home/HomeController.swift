//
//  HomeController.swift
//  MyStore
//
//  Created by MacbookPro on 11/23/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let alert: UIAlertController = UIAlertController(title: Text.somethingError.localizedText, message: "errStr3", preferredStyle: .alert)
        let btCancel: UIAlertAction = UIAlertAction(title: Text.cancel.localizedText, style: .cancel, handler: nil)
        alert.addAction(btCancel)
        present(alert, animated: true, completion: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "cell")
        setupRX()
    }
    private func setupRX() {
        if Profile.share.id == nil || Profile.share.id == "0" {
            if let currentUser = Auth.auth().currentUser {
                let tableProfileUser = fw.share.dataBase.child(FirebaseTable.users.getTableUser()).child(currentUser.uid)
                tableProfileUser.observe(.value) { (data) in
                    let alert = self.showLoading()
                    if data.value is NSNull {
                        NSLog("Không có profile")
                    } else {
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true, completion: {
                                Profile.share.inputProfile(user: UserFireBase(snapshot: data))
                            })
                        }
                        
                    }
                }
            }
        } else {
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
    }

}
extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }

}
extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    
}
