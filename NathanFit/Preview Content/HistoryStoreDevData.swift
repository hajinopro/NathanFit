//
//  HistoryStoreDevData.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/27.
//

import Foundation

extension HistoryStore {
    func createDevData() {
        exerciseDays = [
            ExerciseDay(
                date: Date().addingTimeInterval(-86400),
                exercise: [
                    Exercise.exercises[0].exerciseName,
                    Exercise.exercises[1].exerciseName,
                    Exercise.exercises[2].exerciseName,
                ]),
            ExerciseDay(
                date: Date().addingTimeInterval(-86400 * 2),
                exercise: [
                    Exercise.exercises[1].exerciseName,
                    Exercise.exercises[0].exerciseName
                ])
        ]
    }
}
