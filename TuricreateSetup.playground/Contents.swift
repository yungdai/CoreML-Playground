//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

public func parseTestAndTrainingFile(prefixName: String, numberOfFiles: Int, noTraining: [Any]) {
	
	let testFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_test.txt")
	
	let trainingFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_train.txt")
	
	var testTextToWrite = ""
	var trainingTextToWrite = ""
	let noTrainingSet = createSetFromRanges(range: noTraining)
	
	for i in 1...numberOfFiles {
		switch i {
		case 0...9:
			testTextToWrite = testTextToWrite + prefixName + "_0000\(i)\n"
			if !noTrainingSet.contains(i) {
				trainingTextToWrite = trainingTextToWrite + prefixName + "_0000\(i)\n"
			}
			
		case 10...99:
			testTextToWrite = testTextToWrite + prefixName + "_000\(i)\n"
			if !noTrainingSet.contains(i)  {
				trainingTextToWrite = trainingTextToWrite + prefixName + "_000\(i)\n"
			}
			
		case 100...999:
			testTextToWrite = testTextToWrite + prefixName + "_00\(i)\n"
			if !noTrainingSet.contains(i) {
				trainingTextToWrite = trainingTextToWrite + prefixName + "_00\(i)\n"
			}
			
		case 1000...9999:
			testTextToWrite = testTextToWrite + prefixName + "_0\(i)\n"
			if !noTrainingSet.contains(i) {
				trainingTextToWrite = trainingTextToWrite + prefixName + "_0\(i)\n"
			}
			
		case 10000...99999:
			testTextToWrite = testTextToWrite + prefixName + "_\(i)\n"
			if !noTrainingSet.contains(i) {
				trainingTextToWrite = trainingTextToWrite + prefixName + "_\(i)\n"
			}
			
		default: return
		}
	}
	
	do {
		print(testTextToWrite)
		try testTextToWrite.write(to: testFileToWrite, atomically: true, encoding: .utf8)
		try trainingTextToWrite.write(to: trainingFileToWrite, atomically: true, encoding: .utf8)
	} catch {
		
		print("Unable to write file: \(error)")
	}
}


// Utility to create [Int] of an array of ranges of Int's
private func createSetFromRanges(range: [Any]) -> Set<Int> {
	
	var returnedSet = Set<Int>()
	
	for object in range {
		
		switch object {
		case is Int:
			returnedSet.insert(object as! Int)
		case is ClosedRange<Int>:
			
			let objectRange = object as! ClosedRange<Int>
			
			for i in objectRange {
				
				returnedSet.insert(i)
			}
			
		default: break
		}
	}
	
	return returnedSet
}

public func parseInfoFile(prefixName: String, numberOfFiles: Int, difficult:[Any], truncated: [Any], noTraining: [Any]) {
	
	// create a file ending in _info.txt
	let infoFileToWrite = playgroundSharedDataDirectory.appendingPathComponent(prefixName + "_info.txt")
	
	var infoTextToWrite = ""
	
	let truncatedSet = createSetFromRanges(range: truncated)
	let difficultSet = createSetFromRanges(range: difficult)
	let noTrainingSet = createSetFromRanges(range: noTraining)
	
	for i in 1...numberOfFiles {
		
		// parse the additional info dictionary, if there is nothing it should be an empty string
		var additionalString = (truncatedSet.contains(i)) ? "truncated" : ""
		
		if difficultSet.contains(i) {
			additionalString = (additionalString == "") ? "difficult" : "\(additionalString) difficult"
		}
		
		let trainingString = (noTrainingSet.contains(i)) ? "training" : "notraining"
		
		switch i {
		case 0...9:
			infoTextToWrite = infoTextToWrite + prefixName + "_0000\(i).image.png: \(trainingString) testing\n  \(prefixName)_0000\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 10...99:
			infoTextToWrite = infoTextToWrite + prefixName + "_000\(i).image.png: \(trainingString) testing\n  \(prefixName)_000\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 100...999:
			infoTextToWrite = infoTextToWrite + prefixName + "_00\(i).image.png: \(trainingString) testing\n  \(prefixName)_00\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 1000...9999:
			infoTextToWrite = infoTextToWrite + prefixName + "_0\(i).image.png.png: \(trainingString) testing\n  \(prefixName)_0\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		case 10000...99999:
			infoTextToWrite = infoTextToWrite + prefixName + "_\(i).image.png.png: \(trainingString) testing\n  \(prefixName)_\(i).mask.0.png: \(prefixName) \(additionalString)\n"
		default: return
		}
		
	}
	
	// try writing the file as an .utf8 file
	do {
		print(infoTextToWrite)
		try infoTextToWrite.write(to: infoFileToWrite, atomically: true, encoding: .utf8)
	} catch {
		
		print("Unable to write file: \(error)")
	}
}

/// Prepare the files in the specified folder for Turicreate Object Detection
public func prepareObjectDetectionData(withFilePrefixName prefixName: String, numberOfFiles: Int, difficult: [Any], truncated: [Any], noTraining: [Any]) {
	
	parseInfoFile(prefixName: prefixName, numberOfFiles: numberOfFiles, difficult: difficult, truncated: truncated, noTraining: noTraining)
	parseTestAndTrainingFile(prefixName: prefixName, numberOfFiles: numberOfFiles, noTraining: noTraining)
}


// Example run for the some card sets
let debitDifficult: [Any] = [13, 24, 27...31, 39...46, 60, 67, 71...75, 82...85, 88...95, 105, 106, 114]

let debitTrucated: [Any] = [12, 24, 26...31, 37, 39...46, 60, 67, 71...75, 82...85, 88...95, 105, 106, 114...155]

let noTrainDebit: [Any] = [44...46]

let visaDifficult: [Any] = [18...23, 30...75, 125, 126]

let visaTruncated: [Any] = [13, 18...23, 26, 30...36, 45, 46...60, 62, 63, 66...68, 72...75, 110, 117, 118, 126, 127, 136...153, 200...203, 205]

let noTrainVisa: [Any] = [36, 45...53]

prepareObjectDetectionData(withFilePrefixName: "CIBCAdvantageDebitCard", numberOfFiles: 235, difficult: debitDifficult, truncated: debitTrucated, noTraining: noTrainDebit)
prepareObjectDetectionData(withFilePrefixName: "CIBCAeroplanInfiniteVisaCard", numberOfFiles: 233, difficult: visaDifficult, truncated:  visaTruncated, noTraining: noTrainVisa)
