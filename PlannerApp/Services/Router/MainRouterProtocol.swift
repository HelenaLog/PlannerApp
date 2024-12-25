import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assembly: AssemblyProtocol? { get set }
}
