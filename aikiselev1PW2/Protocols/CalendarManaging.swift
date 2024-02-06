//
//  CalendarManaging.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 06.02.2024.
//

import EventKit

protocol CalendarManaging{
    func create(eventModel: CalendarEventModel)-> Bool
}
