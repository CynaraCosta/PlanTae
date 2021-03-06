//
//  AnalyzePlant.swift
//  PlanTae
//
//  Created by Cynara Costa on 12/05/22.
//

import UIKit

class AnalyzePlant: UIViewController {
    
    var timeDateLabel: Timer?
    var planta: Plant?
    var cellsToShow: [CellModel] = []
    
    private let dateString: UILabel = {
        let dateString = UILabel()
        dateString.frame = CGRect(x: 0, y: 0, width: 115, height: 25)
        dateString.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        dateString.text = "Place hold"
        dateString.textColor = UIColor(named: "verde-escuro")
        return dateString
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cellsToShow = teste()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cellsToShow = teste()
        
//        print(cellsToShow)
//        print(arrayTesteInterval)
//        print(arrayTesteLastTime)
        
        timeDateLabel = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeLabelText), userInfo: nil, repeats: true)
        
        view.backgroundColor = .tertiarySystemBackground
        
        let tableView = UITableView()
        tableView.register(CustomTableViewCellAnalyze.self, forCellReuseIdentifier: CustomTableViewCellAnalyze.identifier)
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        
        let plantImage = UIImageView()
        plantImage.image = UIImage(named: whichPlant())
        plantImage.contentMode = .scaleAspectFit
        plantImage.clipsToBounds = true
        
        view.addSubview(plantImage)
        
        plantImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plantImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            plantImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        view.addSubview(dateString)
        dateString.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateString.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 24),
            dateString.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
        ])
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8),
            tableView.topAnchor.constraint(equalTo: dateString.bottomAnchor, constant: 24),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
        
    }
    
    func teste() -> [CellModel] {
        var array: [CellModel] = []
        let namePlant: String = self.title!
        let plantNumber = myPlants.firstIndex(where: {$0.name == namePlant})!
        // berenice = 0
        // barroca = 1
        // ale = 2
        var plant = myPlants[plantNumber]
        
        plant = planta ?? plant
        let waterOn: Bool = plant.Interval(startTime: plant.waterLastTime, duration: plant.waterInterval)
        let scissorsOn: Bool = plant.Interval(startTime: plant.scissorLastTime, duration: plant.scissorInterval)
        let sunOn: Bool = plant.Interval(startTime: plant.sunBathLastTime, duration: plant.sunBathInterval)
        let fertilizerOn: Bool = plant.Interval(startTime: plant.fertilizerLastTime, duration: plant.fertilizerInterval)
        let insecticideOn: Bool = plant.Interval(startTime: plant.insecticideLastTime, duration: plant.insecticideInterval)
        
        if waterOn {
            let waterCell = cells[0]
            array.append(waterCell)
        }
        
        if scissorsOn {
            let scissorsCell = cells[1]
            array.append(scissorsCell)
        }
        
        if sunOn {
            let sunCell = cells[2]
            array.append(sunCell)
        }
        
        if fertilizerOn {
            let fertilizeCell = cells[3]
            array.append(fertilizeCell)
        }
        
        if insecticideOn {
            let insecticideCell = cells[4]
            array.append(insecticideCell)
        }
        
        return array
    }
    
    
    @objc func whichPlant() -> String{
        let namePlant: String = self.title!
        let plantNumber = myPlants.firstIndex(where: {$0.name == namePlant})! + 1
        let number = String(plantNumber)
        let imageName = "planta" + number + ".svg"
        return imageName
        }
    
    @objc func changeLabelText(){
        dateString.text = changeDate()
    }
    
    func changeDate() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd MMMM, yyyy"
        let now = dateFormater.string(from: Date())
        return now
    }
        
}

