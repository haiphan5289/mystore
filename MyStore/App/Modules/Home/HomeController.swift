//
//  HomeController.swift
//  MyStore
//
//  Created by MacbookPro on 11/23/19.
//  Copyright © 2019 MacbookPro. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dataSource: [ProductsFirebase] = []
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
        guard let currentUser = Auth.auth().currentUser else { return }
        if Profile.share.id == nil || Profile.share.id == "0" {
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
        } else {}
        let tableProduct = fw.share.dataBase.child(FirebaseTable.products.getTableUser())
        tableProduct.observe(.childAdded) { (data) in
            print(data.value)
            if data.value is NSNull {
                NSLog("Không có profile")
            } else {
                let item = ProductsFirebase(snapshot: data)
                self.dataSource.append(item)
                self.tableView.reloadData()
            }
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
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        let detail = self.dataSource[indexPath.row]
        cell.lbTitle.text = detail.title
        cell.lbPrice.text = detail.price
        cell.lbDescription.text = detail.description
        if let urlString = detail.arrayImage?.first {
            cell.imgProduct.kf.setImage(with: URL(string: urlString))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.dataSource[indexPath.row]
//        let vc = HomeDetailVC(model: detail)
        let vc = HomeDetailVC(nibName: "HomeDetailVC", bundle: nil) as! HomeDetailVC
        vc.model = detail
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
