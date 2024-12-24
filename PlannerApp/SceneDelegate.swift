import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let assembly = Assembly()
        let router = Router(navigationController: navigationController, assembly: assembly)
        router.taskListViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
