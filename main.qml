import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: wind
    visible: true
    width: 1600
    height: 900
    title: qsTr("My Clock")

    Item {
        id: digit_con
        anchors.centerIn: parent

        //property alias city: cityLabel.text
        property int hours
        property int minutes
        property int seconds
        property int digit4
        property int digit5
        property real shift: 0
        property bool night: false
        property bool internationalTime: true //Unset for local time

        function timeChanged() {
            var date = new Date;
            hours = internationalTime ? date.getUTCHours() + Math.floor(shift) : date.getHours()
            night = ( hours < 7 || hours > 19 )
            minutes = internationalTime ? date.getUTCMinutes() + ((shift % 1) * 60) : date.getMinutes()
            seconds = date.getUTCSeconds()
            digit4 = seconds/10
            digit5 = seconds % 10
            console.log(seconds)
        }

        Timer {
            interval: 200; running: true; repeat: true;
            onTriggered: digit_con.timeChanged()
        }
            Digit {
                id: d4
                height_digit: (550/1080) * wind.height
                width_digit: (320/550) * height_digit
                width_seg: (32/1080) * wind.height
                state: digit_con.digit4.toString()
                base_x: -180
            }
            Digit {
                id: d5
                height_digit: (550/1080) * wind.height
                width_digit: (320/550) * height_digit
                width_seg: (32/1080) * wind.height
                state: digit_con.digit5.toString()
                base_x: 180
            }
        transform: Translate {x : -d5.width_digit/2; y: -d5.height_digit/2}
    }
}
