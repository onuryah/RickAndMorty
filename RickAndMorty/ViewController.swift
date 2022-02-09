//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Ceren Çapar on 5.02.2022.
//

import UIKit
import SnapKit
import SDWebImage

class ViewController: UIViewController {
    let myTableView : UITableView = {
            let t = UITableView()
            t.translatesAutoresizingMaskIntoConstraints = false
            return t
        }()
    var titleField = UILabel()
    let ikonButton = UIButton()
    var dataArray = [LaunchListQuery.Data.Character.Result?]()

    override func viewDidLoad() {
        setTitle()
        setTableView()
        myTableView.delegate = self
        myTableView.dataSource = self
        fetchDatas()
        setIkon()
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        if let datas = dataArray[indexPath.row]{
            if let name = datas.name{
                cell.name.text = "Name: "+name
            }
            if let location = datas.location?.name{
                cell.location.text = "Location: "+location
            }
            if let id = datas.id{
                cell.id.text = "#id: "+id
            }
            if let urlString = datas.image{
                if let url = URL(string: urlString){
                    cell.characterImageView.sd_setImage(with: url)
                }
            }
        }
        
        cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return cell
    }

    
    fileprivate func setTableView(){
        self.view.addSubview(myTableView)
        self.myTableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        myTableView.rowHeight = 281
        myTableView.register(Cell.self, forCellReuseIdentifier: "cell")
        myTableView.snp.makeConstraints { make in
            make.topMargin.equalTo(titleField.snp_bottomMargin).offset(22)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    fileprivate func fetchDatas(){
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
          switch result {
          case .success(let graphQLResult):
              if let datas = graphQLResult.data?.characters?.results{
                  DispatchQueue.main.async {
                      self.dataArray = datas
                      self.myTableView.reloadData()
                  }
                  
              }
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
    
    fileprivate func setTitle(){
        titleField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleField.font = UIFont(name: "Roboto-Bold", size: 24)
        titleField.textAlignment = .center
        titleField.text = "Rick and Morty"
        let parent = self.view!
        parent.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.width.equalTo(163)
            make.height.equalTo(28)
            make.centerX.equalTo(view.snp.centerX)
            make.topMargin.equalTo(28)
        }
    }
    
    fileprivate func setIkon(){
        
        let parent = self.view!
        parent.addSubview(ikonButton)
        ikonButton.setImage(UIImage(named: "Group 4"), for: .normal)
        ikonButton.snp.makeConstraints { make in
            make.width.equalTo(23)
            make.height.equalTo(23.83)
            make.left.equalTo(328)
            make.topMargin.equalTo(24)
        }
    }
    
}

