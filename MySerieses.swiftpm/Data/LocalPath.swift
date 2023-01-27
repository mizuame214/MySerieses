import Foundation

class LocalPath
{
    static let docURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    static let docFolderPath = docURLs.first!.path
    
    static func localFile(fibName: String, fibExt: String) -> String
    {
        return docFolderPath + "/" + fibName + "." + fibExt
    }
}
