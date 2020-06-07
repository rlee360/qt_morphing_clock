import QtQuick 2.0

Item {
    id: single_digit
    property var height_digit: 550
    property var width_digit: 320
    property var width_seg: 32
    property var base_x: 0
    property var anim_speed: 400

    //while one could just do _foo, this does not exactly enforce privacy
    //property var _foo: width_digit/2

    //we effectively namespace here
    QtObject {
        id: horiz_seg
        property var len: width_digit - 2*width_seg
        property var xcoord_left: width_seg + base_x
        property var xcoord_right: width_digit - width_seg + base_x
        property var ycoord_a: 0
        property var ycoord_g: height_digit/2 - width_seg/2
        property var ycoord_d: ycoord_g*2
    }

    QtObject {
        id: vert_seg
        property var len: (height_digit - 3*width_seg)/2
        property var xcoord_left: 0 + base_x
        property var xcoord_right: width_digit - width_seg + base_x
        property var ycoord_b: width_seg
        property var ycoord_c: 2*width_seg + len
        property var ycoord_f: width_seg
        property var ycoord_e: 2*width_seg + len
    }

//    function foo() {
//        switch(num) {
//        case 0:
//            a.visible =  true
//            b.visible =  true
//            c.visible =  true
//            d.visible =  true
//            e.visible =  true
//            f.visible =  true
//            g.visible = false
//            break
//        case 1:

//        }
//    }

    Rectangle {
        id: a
        x: horiz_seg.xcoord_left
        y: horiz_seg.ycoord_a
        width: horiz_seg.len
        height: width_seg
        color: "#000000"

//        MouseArea {
//            anchors.fill: parent
//            onClicked: animate_a_rl2.running=true
//        }
    }

    Rectangle {
        id: b
        x: vert_seg.xcoord_right
        y: vert_seg.ycoord_b
        width: width_seg
        height: vert_seg.len
        color: "#000000"

    }

    Rectangle {
        id: c
        x: vert_seg.xcoord_right
        y: vert_seg.ycoord_c
        width: width_seg
        height: vert_seg.len
        color: "#000000"

    }

    Rectangle {
        id: d
        x: horiz_seg.xcoord_left
        y: horiz_seg.ycoord_d
        width: horiz_seg.len
        height: width_seg
        color: "#000000"
    }

    Rectangle {
        id: e
        x: vert_seg.xcoord_left
        y: vert_seg.ycoord_e
        width: width_seg
        height: vert_seg.len
        color: "#000000"
    }

    Rectangle {
        id: f
        x: vert_seg.xcoord_left
        y: vert_seg.ycoord_f
        width: width_seg
        height: vert_seg.len
        color: "#000000"
    }

    Rectangle {
        //visible: false
        id: g
        x: horiz_seg.xcoord_left
        y: horiz_seg.ycoord_g
        width: horiz_seg.len
        height: width_seg
        color: "#000000"
    }

    states: [
        State {
            name: "0"
        },
        State {
            name: "1"
//            PropertyChanges {target: a; visible: false}
//            PropertyChanges {target: b; visible: true}
//            PropertyChanges {target: c; visible: true}
//            PropertyChanges {target: d; visible: false}
//            PropertyChanges {target: e; visible: false}
//            PropertyChanges {target: f; visible: false}
//            PropertyChanges {target: g; visible: false}
        },
        State {
            name: "2"
//            PropertyChanges {target: a; visible: true}
//            PropertyChanges {target: b; visible: true}
//            PropertyChanges {target: c; visible: false}
//            PropertyChanges {target: d; visible: true}
//            PropertyChanges {target: e; visible: true}
//            PropertyChanges {target: f; visible: false}
//            PropertyChanges {target: g; visible: true}
        },
        State {
            name: "3"
//            PropertyChanges {target: a; visible: true}
//            PropertyChanges {target: b; visible: true}
//            PropertyChanges {target: c; visible: true}
//            PropertyChanges {target: d; visible: true}
//            PropertyChanges {target: e; visible: false}
//            PropertyChanges {target: f; visible: false}
//            PropertyChanges {target: g; visible: true}
        },
        State {name: "4"},
        State {name: "5"},
        State {name: "6"},
        State {name: "7"},
        State {name: "8"},
        State {name: "9"}
    ]

    transitions: [
        Transition {
            from: "0"
            to: "1"
            //HIDDEN: g
            PropertyAnimation {target: g; property: "x"; to: horiz_seg.xcoord_right; duration: 0}
            PropertyAnimation {target: g; property: "width"; to: 0; duration: 0}

            // a,d shrink L -> R
            PropertyAnimation {target: a; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: a; property: "width"; to: 0; duration: anim_speed}
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: 0; duration: anim_speed}

            //e, f, translate, go to length 0
            PropertyAnimation {target: e; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: f; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
        },
        Transition {
            from: "1"
            to: "2"
            //don't touch b or f
            //a,d,g grows R -> L
            PropertyAnimation {target: a; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: a; property: "width"; to: horiz_seg.len; duration: anim_speed}
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: horiz_seg.len; duration: anim_speed}
            PropertyAnimation {target: g; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: g; property: "width"; to: horiz_seg.len; duration: anim_speed}

            // c, e translate R -> L
            PropertyAnimation {target: c; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
            },
        Transition {
            from: "2"
            to: "3"
            // c, e translate L -> R
            PropertyAnimation {target: c; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}
        },

        Transition {
            from: "3"
            to: "4"
            //move f into position
            PropertyAnimation {target: f; property: "x"; to: vert_seg.xcoord_left; duration: 0}
            PropertyAnimation {target: f; property: "height"; to: 0; duration: 0}

            //a shrinks L -> R
            PropertyAnimation {target: a; property: "width"; to: 0; duration: anim_speed}

            //d shrinks R -> L
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: 0; duration: anim_speed}

            //f grows Top -> Bottom
            PropertyAnimation {target: f; property: "height"; to: vert_seg.len; duration: anim_speed}
        },

        Transition {
            from: "4"
            to: "5"
            //make sure a, d are in the right place Make them 0 width before moving
            PropertyAnimation {target: a; property: "width"; to: 0; duration: 0}
            PropertyAnimation {target: a; property: "x"; to: horiz_seg.xcoord_right; duration: 0}
            PropertyAnimation {target: d; property: "width"; to: 0; duration: 0}
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_right; duration: 0}

            //a,d grows R -> L
            PropertyAnimation {target: a; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: a; property: "width"; to: horiz_seg.len; duration: anim_speed}
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: horiz_seg.len; duration: anim_speed}

            //b shrinks Bottom -> Top
            PropertyAnimation {target: b; property: "height"; to: 0; duration: anim_speed}
        },
        Transition {
            from: "5"
            to: "6"
            //e translates R -> L
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
        },
        Transition {
            from: "6"
            to: "7"
            // c, e, f translate L -> R
            PropertyAnimation {target: c; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: f; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}

            //g shrinks L -> R
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: 0; duration: anim_speed}
            PropertyAnimation {target: g; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: g; property: "width"; to: 0; duration: anim_speed}
        },
        Transition {
            from: "7"
            to: "8"
            PropertyAnimation {target: b; property: "height"; to: vert_seg.len; duration: 0}

            //e,f translates R -> L
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: f; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}

            //a,d,g grows R -> L
            PropertyAnimation {target: a; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: a; property: "width"; to: horiz_seg.len; duration: anim_speed}
            PropertyAnimation {target: d; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: d; property: "width"; to: horiz_seg.len; duration: anim_speed}
            PropertyAnimation {target: g; property: "x"; to: horiz_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: g; property: "width"; to: horiz_seg.len; duration: anim_speed}
        },
        Transition {
            from: "8"
            to: "9"
            //e translates L -> R
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}
        },
        Transition {
            from: "9"
            to: "0"
            PropertyAnimation {target: e; property: "height"; to: 0; duration: 0}
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: 0}

            //d shrinks R -> L
            //PropertyAnimation {target: g; property: "x"; to: horiz_seg.xcoord_right; duration: anim_speed}
            PropertyAnimation {target: g; property: "width"; to: 0; duration: anim_speed}

            //e grows again
            PropertyAnimation {target: e; property: "height"; to: vert_seg.len; duration: anim_speed}
        },
        Transition {
            from: "5"
            to: "0"
            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_left; duration: 0}
            PropertyAnimation {target: b; property: "height"; to: vert_seg.len; duration: 0}
            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}

            //g shrinks R -> L
            PropertyAnimation {target: g; property: "width"; to: 0; duration: anim_speed}

            //e grows again
            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
            PropertyAnimation {target: e; property: "height"; to: vert_seg.len; duration: anim_speed}
        }
//        Transition {
//            from: "3"
//            to: "0"
//            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_left; duration: 0}
//            PropertyAnimation {target: b; property: "height"; to: vert_seg.len; duration: 0}
//            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}

//            //g shrinks R -> L
//            PropertyAnimation {target: g; property: "width"; to: 0; duration: anim_speed}

//            //e grows again
//            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
//            PropertyAnimation {target: e; property: "height"; to: vert_seg.len; duration: anim_speed}
//        },
//        Transition {
//            from: "2"
//            to: "0"
//            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_left; duration: 0}
//            PropertyAnimation {target: b; property: "height"; to: vert_seg.len; duration: 0}
//            PropertyAnimation {target: b; property: "x"; to: vert_seg.xcoord_right; duration: anim_speed}

//            //g shrinks R -> L
//            PropertyAnimation {target: g; property: "width"; to: 0; duration: anim_speed}

//            //e grows again
//            PropertyAnimation {target: e; property: "x"; to: vert_seg.xcoord_left; duration: anim_speed}
//            PropertyAnimation {target: e; property: "height"; to: vert_seg.len; duration: anim_speed}
//        }
    ]
}
