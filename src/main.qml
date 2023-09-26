/*
 * Copyright (C) 2019 Florent Revest <revestflo@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import org.asteroid.controls 1.0
import org.asteroid.utils 1.0
import QtQuick.VirtualKeyboard 2.0
import QtQuick.VirtualKeyboard.Settings 2.15
import Terminal 1.0
import Nemo.Configuration 1.0


Application {
    id: app
    
    Terminal {id:terminal}
	
	property string cmd: ""
	property string cmdStr: ""
	property int len: 0
    
    centerColor: "#b04d1c"
    outerColor: "#421c0a"
    leftIndicVisible: false
    topIndicVisible: false
	rightIndicVisible: false 
    bottomIndicVisible: false
	
	function scrollUpdate(str){
		len += Dims.h(6) * Math.round(str.length/28)
		cmdStr += str 
	}
	
LayerStack {
	id: layerStack
	firstPage: terminalPage

}

Component {
	id:terminalPage	  	
	Item {
		id:rootM
		
		Rectangle {
        	 	id:test
        	 	width : 300
        	 	height: 300
        	 	border.color : "Black"
				border.width : 4
				anchors.horizontalCenter : parent.horizontalCenter
        }
		
		Flickable {
			id: flickable1
        	anchors.horizontalCenter : parent.horizontalCenter
			clip: true
        	height: 300
        	width: 300
        	contentWidth: parent.width
        	contentHeight:parent.height + len  
        	
        	Text {
        		id: terminalTxt
        		//textFormat:Text.MarkdownText
            	text: cmdStr
            	anchors.left: parent.left
            	anchors.right: parent.right
            	font.pixelSize: Dims.h(5)
        		wrapMode: Text.Wrap
        		elide: Text.ElideRight
        		maximumLineCount: 100000
           	}		
       	}
		
		IconButton {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top:flickable1.bottom
			width: Dims.l(20)
    		height: width
			iconName: "ios-add-circle-outline"
			onClicked: { 
				layerStack.push(commandLine)
								
 			}
		}
	}
}
Component {
	id:commandLine
	Item{
		id:rootL
		TextField {
    		id: commandTxt
    		anchors.top:parent.top
    		anchors.topMargin :40
    		anchors.horizontalCenter:parent.horizontalCenter
        	width: Dims.w(80)
        	previewText: qsTrId("Command")
    	}	
		InputPanel {
    		id: kbd
        	anchors {
        	    verticalCenter: parent.verticalCenter
        	    horizontalCenter: parent.horizontalCenter
         	}
        	width:parent.width * 0.95 //Dims.w(95)
        	visible: active
    	}
		IconButton {
 			anchors.bottom : parent.bottom
 			anchors.horizontalCenter : parent.horizontalCenter		
 			iconName: "ios-checkmark-circle-outline"
 			onClicked: {
				cmd = terminal.command(commandTxt.text)
				scrollUpdate(cmd)  				
 				layerStack.pop(rootL)				
 			}
		}
		Component.onCompleted: {
    	    VirtualKeyboardSettings.styleName = "watch"
    	}
	}
}
	
}

