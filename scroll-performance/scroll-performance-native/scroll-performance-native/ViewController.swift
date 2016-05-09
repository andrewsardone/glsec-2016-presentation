import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("Table View Cell") as? TableViewCell) ?? TableViewCell()
        cell.avatarView.backgroundColor = UIColor.randomColor()
        return cell
    }

}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
}

extension UIColor {
    @nonobjc static let possibleColors = [
        UIColor.blackColor(),
        UIColor.blueColor(),
        UIColor.brownColor(),
        UIColor.cyanColor(),
        UIColor.darkGrayColor(),
        UIColor.grayColor(),
        UIColor.greenColor(),
        UIColor.lightGrayColor(),
        UIColor.magentaColor(),
        UIColor.orangeColor(),
        UIColor.purpleColor(),
        UIColor.redColor(),
        UIColor.yellowColor(),
    ]

    class func randomColor() -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(possibleColors.count)))
        return possibleColors[randomIndex]
    }
}

