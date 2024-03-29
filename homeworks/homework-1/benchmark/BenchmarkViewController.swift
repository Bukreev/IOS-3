
import UIKit

class BenchmarkViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var timers:[TimerItem] = []
    var isAutoUpdateChart = true
    let updateTimerBehavior: UpdateTimersBehavior = UpdateTimersBehavior()
    
    
    @IBAction func autoUploadToggled(_ sender: UISwitch) {
        if sender.isOn {
            isAutoUpdateChart = true
        } else {
            isAutoUpdateChart = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionCellWidth()
        initTimers()
        addBehaviors(behaviors: [updateTimerBehavior])
        
        let updateSwitch = UISwitch(frame: .zero)
        updateSwitch.isOn = isAutoUpdateChart
        updateSwitch.addTarget(self, action: #selector(autoUploadToggled(_:)), for: .valueChanged)
        let switchItem = UIBarButtonItem(customView: updateSwitch)
        navigationItem.rightBarButtonItem = switchItem
    }
    
    func setupCollectionCellWidth() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }

    func updateCell(_ indexPath:IndexPath) {
        if let cellView = collectionView.cellForItem(at: indexPath) as? TimerViewCell {
            cellView.timerItem = timers[indexPath.row]
            if(isAutoUpdateChart) {
                cellView.updatePieChart()
            }
        }
    }
    
    func resetTimers() {
        timers.removeAll()
        initTimers()
        collectionView.reloadData()
    }
    
    func initTimers() {
        for _ in 1...30 {
            timers.append(TimerItem())
        }
    }
}

extension BenchmarkViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timerViewCell",
                                                         for: indexPath) as? TimerViewCell {
            cell.timerItem = timers[indexPath.row]
            cell.updatePieChart()
            
            if indexPath.row % 2 == 0 {
                cell.setPieSmallMode()
            } else {
                cell.setPieLargeMode()
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension BenchmarkViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateTimerBehavior.didSelectTimer(indexPath, timers[indexPath.row])
        updateCell(indexPath)
    }
    
}
