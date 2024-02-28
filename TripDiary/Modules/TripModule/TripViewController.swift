//
//  TripViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import UIKit

class TripViewController: UIViewController {
    
    @IBOutlet weak var tripTableView: UITableView!
    
    var presenter: TripPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setUpModels()
    }
    
    private func configureTableView() {
        tripTableView.delegate = self
        tripTableView.dataSource = self
        tripTableView.register(TripTableViewCell.nib, forCellReuseIdentifier: TripTableViewCell.reuseIdentifier)
    }
    
    @IBAction func addTripTapped(_ sender: Any) {
        presenter.didPressedAddTrip()
    }
}
extension TripViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TripTableViewCell.reuseIdentifier, for: indexPath) as? TripTableViewCell else {
            return UITableViewCell()
        }
        
        if let models = presenter.models?[indexPath.row] {
            cell.configure(with: models)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let tripToDelete = presenter.models?[indexPath.row] {
                do {
                    try presenter.deleteTrip(tripID: tripToDelete.id)
                    
                } catch {
                    print("Error deleting trip: \(error)")
                }
            }
        }
    }
}

extension TripViewController: TripViewControllerProtocol {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tripTableView.reloadData()
        }
    }
}

   
