import Foundation
import Files
import ShellOut

let fontsFolder = try Folder.home.subfolder(at: "Library/Fonts")

if !fontsFolder.containsFile(named: "SourceCodePro-Regular.ttf") {
    print("🅰️  Downloading Source Code Pro font...")

    let fontZipURL = URL(string: "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip")!
    let fontZipData = try Data(contentsOf: fontZipURL)

    print("🅰️  Installing Source Code Pro font...")

    let fontZipFile = try fontsFolder.createFile(named: "SourceCodePro.zip", contents: fontZipData)
    try shellOut(to: "unzip \(fontZipFile.name) -d SourceCodePro", at: fontsFolder.path)

    let sourceCodeProFolder = try fontsFolder.subfolder(named: "SourceCodePro")
    let ttfFolder = try sourceCodeProFolder.subfolders.first!.subfolder(named: "TTF")
    try ttfFolder.files.move(to: fontsFolder)

    try sourceCodeProFolder.delete()
    try fontZipFile.delete()
}

print("🎨  Installing Xcode theme...")

// Navigate to the Themes folder
let themesFolder = try Folder.current.subfolder(named: "Themes")

// Get all .xccolortheme files in the Themes folder
let themeFiles = themesFolder.files.filter { $0.extension == "xccolortheme" }

let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

for themeFile in themeFiles {
    let themeData = try themeFile.read()
    let themeDestination = try themeFolder.createFile(named: themeFile.name)
    try themeDestination.write(themeData)
    print("🎉 \(themeFile.name) successfully installed")
}

print("")
print("🎉 Xcode's Themes successfully installed")
print("👍 Select it in Xcode's preferences to start using it (you may have to restart Xcode first)")
