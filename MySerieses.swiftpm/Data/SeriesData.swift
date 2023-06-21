import Foundation

struct SeriesData : Identifiable, Codable, Equatable
{
    var id: String = UUID().uuidString
    var title: String
    var num: Int
    var datas: SeriesesAndDetailsData
    
    static func parse(json: Data) -> [SeriesData]
    {
        do
        {
            let serieses = try JSONDecoder().decode([SeriesData].self, from:json)
            print("読み込めたよ")
            return serieses
        }
        catch
        {
            print("JSONを配列に変換できませんでした")
            //print(error.localizedDescription)
            return []
        }
    }
    
    static func save(path: String, data: [SeriesData])
    {
        do
        {
            let userJson = try JSONEncoder().encode(data)
            let url = URL(fileURLWithPath: path)
            try userJson.write(to: url, options: [.atomic])
            print("保存完了")
        }
        catch
        {
            print("ファイルの保存に失敗")
            //print(error.localizedDescription)
        }
    }
    
    static func load(path: String) -> [SeriesData]
    {
        do
        {
            let url = URL(fileURLWithPath: path)
            let userJson = try Data(contentsOf: url)
            //print("\(url)のファイルをロードした")
            return SeriesData.parse(json: userJson)
        }
        catch
        {
            print("ファイルの読み込みに失敗")
            //print(error.localizedDescription)
            return []
        }
    }
    
    static func clear(path: String)
    {
        do
        {
            try FileManager.default.removeItem(atPath: path)
        }
        catch
        {
            print("ファイル削除に失敗")
            //print(error.localizedDescription)
        }
    }
}
