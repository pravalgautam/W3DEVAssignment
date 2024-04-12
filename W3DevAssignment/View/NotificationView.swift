//
//  NotificationView.swift
//  W3DevAssignment
//
//  Created by Praval Gautam on 12/04/24.
//

import SwiftUI

struct NotificationView: View {
    @State var selectedDate = Date()
      let notify = NotificationHandler()
      
      var body: some View {
          VStack(spacing: 20) {
              Spacer()
              Button("Send notification in 5 seconds") {
                  notify.sendNotification(
                      date: Date(),
                      type: "time",
                      timeInterval: 5,
                      title: "5 second notification",
                      body: "You can write more in here!")
              }
              DatePicker("Pick a date:", selection: $selectedDate, in: Date()...)
              Button("Schedule notification") {
                  notify.sendNotification(
                      date:selectedDate,
                      type: "date",
                      title: "Date based notification",
                      body: "Order Confirmed")
              }.tint(.orange)
              Spacer()
              Text("Not working?")
                  .foregroundColor(.gray)
                  .italic()
              Button("Request permissions") {
                  notify.askPermission()
              }
          }
          .padding()
      }
}

#Preview {
    NotificationView()
}
