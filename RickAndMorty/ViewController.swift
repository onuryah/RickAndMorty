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
    let darkImage = UIImageView()
    var titleField = UILabel()
    let ikonButton = UIButton()
    let frameImage = UIImageView()
    let rickButton = UIButton()
    let mortyButton = UIButton()
    var dataArray = [LaunchListQuery.Data.Character.Result?]()

    override func viewDidLoad() {
        
        setTitle()
        setTableView()
        myTableView.delegate = self
        myTableView.dataSource = self
        fetchDatas()
        setIkon()
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setDarkImage()
        setFrameImage()
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
        
        view.addSubview(ikonButton)
        ikonButton.setImage(UIImage(named: "Group 4"), for: .normal)
        ikonButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        ikonButton.snp.makeConstraints { make in
            make.width.equalTo(23)
            make.height.equalTo(23.83)
            make.left.equalTo(328)
            make.topMargin.equalTo(24)
        }
        
        
    }
    
    @objc func buttonAction(){
        rickButton.isHidden = false
        mortyButton.isHidden = false
        darkImage.isHidden = false
    }
    
    @objc func viewTapped(tapGestureRecognizer: UITapGestureRecognizer){
        darkImage.isHidden = true
    }
    
    func setDarkImage(){
        view.addSubview(darkImage)
        darkImage.isHidden = true
        darkImage.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        darkImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    func setFrameImage(){
        darkImage.addSubview(frameImage)
        frameImage.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        frameImage.layer.cornerRadius = 10
        frameImage.snp.makeConstraints { make in
            make.width.equalTo(327)
            make.height.equalTo(164)
            make.centerY.equalToSuperview().offset(-3)
            make.centerX.equalToSuperview().offset(4)
        }
        let filterLabel = UILabel()
        let mortyLabel = UILabel()
        let rickLabel = UILabel()
        let lineLabel = UILabel()
        rickLabel.text = "Rick"
        mortyLabel.text = "Morty"
        filterLabel.text = "Filter"
        rickButton.addTarget(self, action: #selector(rickButtonClicked), for: .touchUpInside)
        mortyButton.addTarget(self, action: #selector(mortyButtonClicked), for: .touchUpInside)
        
        rickButton.setImage(UIImage(named: "Ellipse 2"), for: .normal)
        mortyButton.setImage(UIImage(named: "Ellipse 2"), for: .normal)
        rickLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        rickLabel.textAlignment = .left
        mortyLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        mortyLabel.textAlignment = .left
        filterLabel.font = UIFont(name: "Roboto-Bold", size: 24)
        filterLabel.textAlignment = .left
        lineLabel.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        frameImage.addSubview(lineLabel)
        frameImage.addSubview(filterLabel)
        frameImage.addSubview(mortyLabel)
        frameImage.addSubview(rickLabel)
        view.addSubview(rickButton)
        view.addSubview(mortyButton)
        rickButton.isHidden = true
        mortyButton.isHidden = true
        rickLabel.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
            make.rightMargin.equalTo(265)
            make.leftMargin.equalTo(16)
        }
        
        mortyLabel.snp.makeConstraints { make in
            make.width.equalTo(63)
            make.height.equalTo(28)
            make.bottomMargin.equalToSuperview().offset(24)
            make.topMargin.equalToSuperview().offset(112)
            make.rightMargin.equalTo(248)
            make.leftMargin.equalTo(16)
        }
        
        filterLabel.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.height.equalTo(28)
            make.bottomMargin.equalToSuperview().offset(120)
            make.topMargin.equalToSuperview().offset(16)
            make.rightMargin.equalTo(255)
            make.leftMargin.equalTo(16)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-2)
            make.height.equalTo(1)
            make.bottomMargin.equalToSuperview().offset(112)
            make.topMargin.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
        }
        
        rickButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.centerY.equalTo(frameImage)
            make.rightMargin.equalTo(20)
            make.leftMargin.equalTo(291)
        }
        
        mortyButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.bottomMargin.equalTo(frameImage).offset(24)
            make.topMargin.equalTo(frameImage).offset(112)
            make.rightMargin.equalTo(20)
            make.leftMargin.equalTo(291)
        }
    }
    
    @objc func rickButtonClicked(){
        DispatchQueue.main.async {
            print("çalışır")
            self.rickButton.setImage(UIImage(named: "Group 6"), for: .normal)
            self.mortyButton.setImage(UIImage(named: "Ellipse 2"), for: .normal)
        }
        rickButton.isHidden = true
        mortyButton.isHidden = true
        darkImage.isHidden = true
    }
    
    @objc func mortyButtonClicked(){
        DispatchQueue.main.async {
            self.rickButton.setImage(UIImage(named: "Ellipse 2"), for: .normal)
            self.mortyButton.setImage(UIImage(named: "Group 6"), for: .normal)
        }
        rickButton.isHidden = true
        mortyButton.isHidden = true
        darkImage.isHidden = true
    }
    
}

