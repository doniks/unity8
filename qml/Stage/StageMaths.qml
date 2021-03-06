import QtQuick 2.4
import Unity.Application 0.1
import Ubuntu.Components 1.3

QtObject {
    id: root

    // input
    property int itemIndex: 0
    property int nextInStack: 0
    property int sceneWidth: 0
    property int sideStageWidth: 0
    property int sideStageX: sceneWidth
    property bool animateX: false
    property int leftEdgeDragProgress: 0

    property int stage: ApplicationInfoInterface.MainStage
    property var thisDelegate: null
    property var mainStageDelegate: null
    property var sideStageDelegate: null

    // output

    // We need to shuffle z ordering a bit in order to keep side stage apps above main stage apps.
    // We don't want to really reorder them in the model because that allows us to keep track
    // of the last focused order.
    readonly property int itemZ: {
        // only shuffle when we've got a main and side stage
        if (thisDelegate.isDash && thisDelegate != mainStageDelegate && leftEdgeDragProgress > 0) {
            return -1; // Keep the dash behind all other apps for the left edge gesture
        }

        if (!sideStageDelegate) return itemIndex;

        // don't shuffle indexes greater than "actives or next"
        if (itemIndex > 2) return itemIndex;

        if (thisDelegate == mainStageDelegate) {
            // Active main stage always at 0
            return 0;
        }

        if (nextInStack > 0) {
            var stageOfNextInStack = appRepeater.itemAt(nextInStack).stage;

            if (itemIndex === nextInStack) {
                // this is the next app in stack.

                if (stage ===  ApplicationInfoInterface.SideStage) {
                    // if the next app in stack is a sidestage app, it must order on top of other side stage app
                    return Math.min(2, topLevelSurfaceList.count-1);
                }
                return 1;
            }
            if (stageOfNextInStack === ApplicationInfoInterface.SideStage) {
                // if the next app in stack is a sidestage app, it must order on top of other side stage app
                return 1;
            }
            return Math.min(2, topLevelSurfaceList.count-1);
        }
        return Math.min(index+1, topLevelSurfaceList.count-1);
    }


    property int itemX: {
        if (mainStageDelegate == thisDelegate) {
            return thisDelegate.isDash ? 0 : leftEdgeDragProgress;
        }
        if (sideStageDelegate == thisDelegate) {
            return sideStageX;
        }
        return thisDelegate.isDash && leftEdgeDragProgress > 0 ? 0 : sceneWidth;
    }
    Behavior on itemX { enabled: root.animateX; UbuntuNumberAnimation {} }

    readonly property int itemWidth: stage == ApplicationInfoInterface.MainStage ?
                                     sideStageDelegate != null ? sideStageX : sceneWidth :
                                     stage == ApplicationInfoInterface.SideStage ? sideStageWidth : sceneWidth
}
