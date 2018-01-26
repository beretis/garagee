import Foundation
import Moya
import Swinject

class DI {

	static var container: Container = {
		let container = Container()

		//Register components
		container.register(CoreDataServiceProtocol.self, factory: { (resolver) -> CoreDataServiceProtocol in
			return CoreDataService.shared
		})
		return container
	}()

}

// MARK: - Access methods
extension DI {

	static func send<T>(_ value: T, withKey key: String) {
		self.container.register(T.self, name: key) { _ -> T in
			return value
		}
	}

	static func get<T>(key: String? = nil) -> T? {
		return self.container.resolve(T.self, name: key)
	}

	static func get<T, P>(arg: P, key: String? = nil) -> T? {
		return self.container.resolve(T.self, name: key, argument: arg)
	}

}

// MARK: - Parameter Keys
extension DI {

	struct Key {
		static var notificationModel = "notificationModel"
		static var selectedNotificationId = "selectedNotificationId"
	}

}
