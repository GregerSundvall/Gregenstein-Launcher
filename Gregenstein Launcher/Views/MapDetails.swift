//
//  MapDetails.swift
//  Gregenstein Launcher
//
//  Created by Greger Sundvall on 2021-01-25.
//

import SwiftUI

struct MapDetails: View {

    var map: Map
    
    var body: some View {
        Text(map.name)
        
        
        List() {
            oneLine(row: map.mapArray[0])
            oneLine(row: map.mapArray[1])
            oneLine(row: map.mapArray[2])
            oneLine(row: map.mapArray[3])
            oneLine(row: map.mapArray[4])
            oneLine(row: map.mapArray[5])
            oneLine(row: map.mapArray[6])
            oneLine(row: map.mapArray[7])
            oneLine(row: map.mapArray[8])
            oneLine(row: map.mapArray[9])
            
            
        }
        
        
    }
    
    
}

struct oneLine: View {
    let row: [Int]
    
    
    
    
    var body: some View {
        
            Text(makeString(row: row))
    }
    func makeString(row: [Int]) -> String{
        var rowString = ""
        for nr in row {
            rowString.append(String(nr))
        }
        return rowString
    }
}


struct MapDetails_Previews: PreviewProvider {
    static var previews: some View {
        
        MapDetails(map: Maps().list[0])
    }
}
