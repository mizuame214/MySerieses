import Foundation

struct SeriesesAndDetailsData : Identifiable, Codable, Equatable
{
    var id: String = UUID().uuidString
    var serieses: [SeriesData]
    var details: [DetailData]
}
