//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

public func parseTestAndTrainingFile(prefixName: String, numberOfFiles: Int) {
	
	let testFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_test.txt")
	
	let trainingFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_train.txt")
	
	var testTextToWrite = ""
	for i in 1...numberOfFiles {
		switch i {
		case 0...9:
			testTextToWrite = testTextToWrite + prefixName + "_0000\(i)\n"
		case 10...99:
			testTextToWrite = testTextToWrite + prefixName + "_000\(i)\n"
		case 100...999:
			testTextToWrite = testTextToWrite + prefixName + "_00\(i)\n"
		case 1000...9999:
			testTextToWrite = testTextToWrite + prefixName + "_0\(i)\n"
		case 10000...99999:
			testTextToWrite = testTextToWrite + prefixName + "_\(i)\n"
		default: return
		}
		print(testTextToWrite)
	}
	
	do {
		try testTextToWrite.write(to: testFileToWrite, atomically: true, encoding: .utf8)
		try testTextToWrite.write(to: trainingFileToWrite, atomically: true, encoding: .utf8)
	} catch {
		
		print("Unable to write file: \(error)")
	}
	
}

public func parseInfoFile(prefixName: String, numberOfFiles: Int, additionalInfo: [Int: String]?) {
	
	// create a file ending in _info.txt
	let infoFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_info.txt")

	var infoTextToWrite = ""
	for i in 1...numberOfFiles {
		
		// parse the additional info dictionary, if there is nothing it should be an empty string
		let additionalString = additionalInfo?[i] ?? ""
		
		switch i {
		case 0...9:
			infoTextToWrite = infoTextToWrite + prefixName + "_0000\(i).image.png: training testing\n  \(prefixName)_0000\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 10...99:
			infoTextToWrite = infoTextToWrite + prefixName + "_000\(i).image.png: training testing\n  \(prefixName)_000\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 100...999:
			infoTextToWrite = infoTextToWrite + prefixName + "_00\(i).image.png: training testing\n  \(prefixName)_00\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 1000...9999:
			infoTextToWrite = infoTextToWrite + prefixName + "_0\(i).image.png.png: training testing\n  \(prefixName)_0\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 10000...99999:
			infoTextToWrite = infoTextToWrite + prefixName + "_\(i).image.png.png: training testing\n  \(prefixName)_\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		default: return
		}
		print(infoTextToWrite)
	}
	
	// try writing the file as an .utf8 file
	do {
		try infoTextToWrite.write(to: infoFileToWrite, atomically: true, encoding: .utf8)
	} catch {
		
		print("Unable to write file: \(error)")
	}
}



/// Prepare the files in the specified folder for Turicreate Object Detection
public func prepareObjectDetection(withFilePrefixName prefixName: String, numberOfFiles: Int, additionalInfo: [Int: String]?) {
	
	parseInfoFile(prefixName: prefixName, numberOfFiles: numberOfFiles, additionalInfo: additionalInfo)
	parseTestAndTrainingFile(prefixName: prefixName, numberOfFiles: numberOfFiles)
}


// Example run for the some card sets
let additionalInfoDebit = [26: "truncated difficult", 27: "truncated difficult", 28: "truncated difficult", 29: "truncated difficult", 30: "truncated difficult", 31: "truncated difficult", 24: "truncated difficult", 39: "truncated difficult", 40: "truncated difficult", 41: "truncated difficult", 42: "truncated difficult", 43: "truncated difficult", 44: "truncated difficult", 45: "truncated difficult", 46: "truncated difficult", 60: "truncated difficult", 67: "truncated difficult", 71: "truncated difficult", 72: "truncated difficult", 73: "truncated difficult", 74: "truncated difficult", 75: "truncated difficult"]


let additionalInfoVisa = [18: "truncated difficult", 19: "truncated difficult", 20: "truncated difficult", 21: "truncated difficult", 22: "truncated difficult", 23: "truncated difficult", 26: "truncated difficult", 30: "difficult", 31: " difficult", 32: "difficult", 33: "difficult", 34: "difficult", 35: "difficult", 36: "truncated difficult", 37: "difficult", 38: "difficult", 39: "difficult", 40: "difficult", 41: "difficult", 42: "truncated difficult", 43: "difficult", 44: "difficult", 45: "truncated difficult", 46: "truncated difficult", 47: "truncated difficult", 48: "truncated difficult", 49: "truncated difficult", 50: "truncated difficult", 51: "truncated difficult", 52: "truncated difficult", 53: "truncated difficult", 54: "truncated difficult", 55: "truncated difficult", 56: "truncated difficult", 57: "truncated difficult", 58: "truncated difficult", 59: "truncated difficult", 60: "truncated difficult", 61: "difficult", 62: "difficult", 63: "difficult", 64: "difficult", 65: "difficult", 66: "truncated difficult", 67: "truncated difficult", 68: "difficult", 69: "difficult", 70: "difficult", 71: "difficult", 72: "truncated difficult", 73: "truncated difficult", 74: "truncated difficult", 75: "truncated difficult",  ]

prepareObjectDetection(withFilePrefixName: "SomeCardSet", numberOfFiles: 78, additionalInfo: additionalInfoDebit)
prepareObjectDetection(withFilePrefixName: "SomeOtherCardSet", numberOfFiles: 75, additionalInfo: additionalInfoVisa)



