//
//  WishCalendarViewController.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.01.2024.
//

import UIKit
import CoreData

class WishCalendarViewController: UIViewController{
    
    enum Constants{
        static let contentInset: UIEdgeInsets = .zero
        
        static let collectionTop: CGFloat = 15
        
        static let cellHeight: CGFloat = 100
        
        static let eventsKey = "EventsKey"
    }
    
    private var events: [NSManagedObject]!
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let addButton: UIButton = UIButton()
    private let calendar: CalendarManager = CalendarManager()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            events = fetchedResults
        }
        catch let error as NSError{
            print("Can't fetch: \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        configureCollection()
        configureAddButton()
    }
    
    private func configureCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            layout.invalidateLayout()
        }
        // Temporary
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
    }
    
    private func configureAddButton(){
        view.addSubview(addButton)
        
        addButton.setBackgroundImage(UIImage(systemName: "plus.circle"), for: UIControl.State.normal)
        addButton.pinBottom(to: view, 25)
        addButton.pinXCenter(to: view)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setWidth(value: 40)
        addButton.setHeight(value: 40)
        
        addButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func addNewEvent(event: WishEventModel){
        calendar.create(eventModel: event)
        saveEvent(event: event)
        collectionView.reloadData()
    }
    
    @objc
    private func addWishButtonPressed(){
        let eventCreation = WishEventCreationView()
        eventCreation.addEvent = addNewEvent
        present(eventCreation, animated: true)
    }
    
    func saveEvent(event: WishEventModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Event", in:managedContext)
        
        let eventEntity = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        
        eventEntity.setValue(event.title, forKey: "name")
        eventEntity.setValue(event.description, forKey: "body")
        eventEntity.setValue(event.startDate, forKey: "startDate")
        eventEntity.setValue(event.endDate, forKey: "endDate")
        
        appDelegate.saveContext()
        events.append(eventEntity)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else{
            return cell
        }
        
        let name = events[indexPath.item].value(forKey: "name") as? String
        let description = events[indexPath.item].value(forKey: "body") as? String
        let startDate = events[indexPath.item].value(forKey: "startDate") as? Date
        let endDate = events[indexPath.item].value(forKey: "endDate") as? Date
        wishEventCell.configure(
            with: WishEventModel(
                title: name!,
                description: description!,
                startDate: startDate!,
                endDate: endDate!)
        )
        return wishEventCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10 , height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
