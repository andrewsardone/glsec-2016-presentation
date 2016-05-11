import UIKit

class ViewController: UITableViewController {

    let fakeTweetData = FakeTweet.fetchData()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 132
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeTweetData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("Table View Cell") as? TableViewCell) ?? TableViewCell()
        cell.avatarView.backgroundColor = fakeTweetData[indexPath.row].avatarBackgroundColor
        cell.nameLabel.text = fakeTweetData[indexPath.row].name
        cell.tweetLabel.text = fakeTweetData[indexPath.row].text
        return cell
    }

}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
}

struct FakeTweet {
    let date: NSDate
    let email: String
    let id: String
    let name: String
    let text: String
    let avatarBackgroundColor: UIColor

    static func fetchData() -> [FakeTweet] {
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
            .flatMap { return NSData(contentsOfFile: $0) }
            .flatMap({ (data) -> [[String: AnyObject]]? in
                do {
                    return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String: AnyObject]]
                }
                catch { return nil }
            })
            ?? []
        return path.map { return FakeTweet(json: $0) }
    }

    init(json: [String: AnyObject]) {
        date = json["date"]
            .flatMap { return $0 as? String }
            .flatMap { return NSTimeInterval($0) }
            .flatMap { return NSDate(timeIntervalSince1970: $0) }
            ?? NSDate()
        email = json["email"] as? String ?? "foo@example.com"
        id = json["id"] as? String ?? NSUUID().UUIDString
        name = json["name"] as? String ?? "No Name"
        text = json["text"] as? String ?? "No Text"
        avatarBackgroundColor = UIColor.randomColor()
    }
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

