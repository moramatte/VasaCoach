//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Activity as Act;

class PositionSampleView extends Ui.DataField {

 enum
    {
        STOPPED,
        PAUSED,
        RUNNING
    }

    var posnInfo = null;
    var counter = 0;
    var mLapCertainty = "";
    hidden var mTimerState = STOPPED;
    var locString = "";

    function initialize() {
        DataField.initialize();

        var info = Act.getActivityInfo();

        //! If the activity timer is greater than 0, then we don't know the lap or timer state.
        if( (info.timerTime != null) && (info.timerTime > 0) )
        {
            mLapCertainty = "?";
        }
    }

    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }
    
     function onTimerLap()
    {
        mLapNumber++;
    }

    //! The timer was started, so set the state to running.
    function onTimerStart()
    {
        mTimerState = RUNNING;
    }

    //! The timer was stopped, so set the state to stopped.
    function onTimerStop()
    {
        mTimerState = STOPPED;
    }

    //! The timer was started, so set the state to running.
    function onTimerPause()
    {
        mTimerState = PAUSED;
    }

    //! The timer was stopped, so set the state to stopped.
    function onTimerResume()
    {
        mTimerState = RUNNING;
    }

    //! The timer was reeset, so reset all our tracking variables
    function onTimerReset()
    {
        mLapNumber = 0;
        mTimerState = STOPPED;
        mLapCertainty = "";
    }

     function compute(info)
    {
         counter = counter +1 ;
         posnInfo = info.currentLocation;
         
         locString = info.currentLocation.toDegrees();
    }

    //! Update the view
    function onUpdate(dc) {
        var string;
        
         dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info xx", Gfx.TEXT_JUSTIFY_CENTER );

        // Set background color
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if( posnInfo != null ) {            
            string = "Location = " + locString;
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 40), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
           
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

    function setPosition(info) {
        posnInfo = info;
        Ui.requestUpdate();
    }


}
