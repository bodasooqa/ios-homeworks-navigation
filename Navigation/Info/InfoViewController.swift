//
//  InfoViewController.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoViewController: ViewController {
    
    let delegate: InfoViewControllerDelegate
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var infoView: InfoView = {
        infoView = InfoView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        infoView.button = .createButton(title: "Show alert") {
            self.onButtonTap()
        }
        
        infoView.configureLayout()
        
        return infoView
    }()
    
    var residents: [String] = []
    
    init(with delegate: InfoViewControllerDelegate) {
        self.delegate = delegate
        super.init("String")
        
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(infoView)
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resident")
        
        infoView.configureTableView(tableView)
    }
    
    func setData() {
        let queue = DispatchQueue(label: "get-data", qos: .userInitiated)
        queue.async {
            self.delegate.getTodo { title in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.infoView.label.text = title
                }
            }
        }
        
        queue.async {
            self.delegate.getPlanet { orbitalPeriod, residents in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.infoView.planetTitleLabel.text = "Orbital period of \(orbitalPeriod)"
                    
                    if let residents = residents {
                        self.setResidents(residents)
                    }
                }
            }
        }
        
    }
    
    func onButtonTap() {
        let alert = UIAlertController(title: "Ok?", message: "Just ok or not ok", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in print("It's OK :)") }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("It's not OK :(") }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func setResidents(_ residents: [String]) {
        let queue = DispatchQueue(label: "get-resident-data", qos: .userInitiated)
        
        residents.forEach { resident in
            queue.async {
                self.delegate.getResident(residentUrl: resident) { residentName in
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        self.residents.append(residentName)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resident", for: indexPath)
        cell.textLabel?.text = residents[indexPath.row]
        
        return cell
    }
    
}
