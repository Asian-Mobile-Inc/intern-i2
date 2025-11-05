import UIKit

struct Developers: Hashable {
    let name: String
    let skill: String
}

final class DeveloperViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var developers = [
        Developers(name: "Tí", skill: "iOS"),
        Developers(name: "Tèo", skill: "Android"),
        Developers(name: "Lan", skill: "Backend"),
        Developers(name: "Hà", skill: "Flutter")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true   // Bật khả năng kéo
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    static func instantiate() -> DeveloperViewController {
        return DeveloperViewController(nibName: "DeveloperViewController", bundle: nil)
    }
}

extension DeveloperViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dev = developers[indexPath.row]
        cell.textLabel?.text = "\(dev.name) – \(dev.skill)"
        return cell
    }
}

extension DeveloperViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        let dev = developers[indexPath.row]
        let itemProvider = NSItemProvider(object: dev.name as NSString) // chỉ cần dummy provider thôi
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = dev  // 👈 đây mới là dữ liệu thực
        return [dragItem]
    }
}

extension DeveloperViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView,
                   canHandle session: UIDropSession) -> Bool {
        // Chỉ nhận dữ liệu nội bộ (cùng app)
        return session.localDragSession != nil
    }

    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        // Cho phép "move" khi cùng app, còn "copy" khi khác app
        let operation: UIDropOperation = (session.localDragSession != nil) ? .move : .copy
        return UITableViewDropProposal(operation: operation, intent: .insertAtDestinationIndexPath)
    }

    func tableView(_ tableView: UITableView,
                   performDropWith coordinator: UITableViewDropCoordinator) {
        guard
            let destinationIndexPath = coordinator.destinationIndexPath,
            let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath,
            let dev = item.dragItem.localObject as? Developers
        else { return }

        tableView.performBatchUpdates {
            // 1️⃣ Xóa item khỏi vị trí cũ
            developers.remove(at: sourceIndexPath.row)

            // 2️⃣ Thêm vào vị trí mới
            developers.insert(dev, at: destinationIndexPath.row)

            // 3️⃣ Cập nhật UI
            tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        }

        coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
    }
}
