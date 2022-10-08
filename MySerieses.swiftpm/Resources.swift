import Foundation

class Resource
{
    static func load(fibName: String, fibExt: String) -> Data
    {
        do
        {
            guard let url = Bundle.main.url(forResource: fibName, withExtension: fibExt)
            else
            {
                print("ファイルがありません:\(fibName).\(fibExt)")
                return Data()
            }
            let data = try Data(contentsOf: url)
            return data
        }
        catch
        {
            print("ファイルが読み込めませんでした")
            return Data()
        }
    }
}
