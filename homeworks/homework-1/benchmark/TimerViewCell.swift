

import UIKit

class TimerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChart!
    
    private let smallSize: CGFloat = 60.0
    private let largeSize: CGFloat = 100.0
    
    @IBAction func updateCell(_ sender: Any) {
        pieChartView.segments = createTimerSegments()
    }
    
    var timerItem : TimerItem? {
        didSet {
            timeLabel.text = timerItem?.displayTime
            if let image = timerItem?.stateImage {
                stateImageView.image = UIImage(named: image)
            } else {
                stateImageView.image = nil
            }
        }
    }
    
    func updatePieChart() {
        pieChartView.segments = createTimerSegments()
    }
    
    func setPieLargeMode() {
        pieChartView.setSize(width: largeSize, height: largeSize)
    }
    
    func setPieSmallMode() {
        pieChartView.setSize(width: smallSize, height: smallSize)
    }
    
    private func createTimerSegments() -> [Segment] {
        var segments = [Segment]()
        
        if (timerItem != nil) && timerItem!.duration > 0 {
            segments.append(Segment(color: UIColor.orange,
                                    value: CGFloat(timerItem!.duration),
                                    label: "launch",
                                    labelColor: UIColor.white))
        }
        
        if (timerItem != nil) && timerItem!.pausedTime > 0 {
            segments.append(Segment(
                color: UIColor.blue,
                value: CGFloat(timerItem!.pausedTime),
                label: "pause",
                labelColor: UIColor.white
                ))
        }
        return segments
    }
    
}
