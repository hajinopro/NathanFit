//
//  HistoryStore.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/27.
//

import Foundation

enum FileError: Error {
    case loadFailure
    case saveFailure
    case urlFailure
}

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercise: [String] = []
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() { }
    
    init(withChecking: Bool) throws {
        #if DEBUG
        //createDevData()
        #endif
        
        do {
            try load()
        } catch {
            throw error
        }
    }
    
    func getURL() -> URL? {
        guard let documentsURL = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask).first else {
            return nil
        }
        return documentsURL.appendingPathComponent("history.plist")
    }
    
    func save() throws {
        guard let dataURL = getURL() else { throw FileError.saveFailure }
        
        let plistData = exerciseDays.map {
            [$0.id.uuidString, $0.date, $0.exercise]
        }
        
        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: plistData,
                format: .binary,
                options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw FileError.saveFailure
        }
    }
    
    func load() throws {
        guard let dataURL = getURL() else { throw FileError.loadFailure }
        
        guard let data = try? Data(contentsOf: dataURL) else { return }
        let plistData = try PropertyListSerialization.propertyList(
            from: data,
            options: [],
            format: nil)
        let convertedPlistData = plistData as? [[Any]] ?? []
        exerciseDays = convertedPlistData.map {
            ExerciseDay(
                date: $0[1] as? Date ?? Date(),
                exercise: $0[2] as? [String] ?? [])
        }
//        do {
//            let data = try? Data(contentsOf: dataURL)
//            let plistData = try PropertyListSerialization.propertyList(
//                from: data,
//                options: [],
//                format: nil)
//            let convertedPlistData = plistData as? [[Any]] ?? []
//            exerciseDays = convertedPlistData.map {
//                ExerciseDay(
//                    date: $0[1] as? Date ?? Date(),
//                    exercise: $0[2] as? [String] ?? [])
//            }
//        } catch {
//            throw FileError.loadFailure
//        }
    }
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        if let firstDate = exerciseDays.first?.date,
           today.isSameDay(as: firstDate) {
            print("Adding \(exerciseName)")
            exerciseDays[0].exercise.append(exerciseName)
        } else {
            exerciseDays.insert(
                ExerciseDay(date: today, exercise: [exerciseName]),
                at: 0)
        }
        
        do {
          try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}


