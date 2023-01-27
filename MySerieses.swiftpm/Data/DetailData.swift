import Foundation

struct DetailData : Identifiable, Codable, Equatable
{
    var id: String = UUID().uuidString
    var title: String
    var message: String
}
