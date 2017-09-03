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

class VasaCoachField extends Ui.DataField {

 enum
    {
        STOPPED,
        PAUSED,
        RUNNING
    }
    
    var start = "Start", smagan = "Smagan", mangsbodarna = "Mangsbodarna", risberg = "Risberg", evertsberg = "Evertsberg", oxberg = "Oxberg", hokberg = "Hokberg", eldris = "Eldris", mora = "Mora";    
    var checkPoints = ["Start", "Smågan", "Mångsbodarna", "Risberg", "Evertsberg", "Oxberg", "Hökberg", "Eldris", "Mora"];
    var latitudes = [61.1613853, 61.09999, 61.07859879999999, 61.0857379, 61.1345709, 61.1167317,61.066667 	, 61.01459, 61.004878];
    var longitudes = [13.263015600000017, 13.45, 13.620492799999965, 13.771363999999949, 13.95615399999997, 14.173285899999996, 14.316667000000052, 14.40676, 14.537003000000027];

 var controlLongitudes = {
    start => 13.263015600000017,
    smagan => 13.45,
    mangsbodarna => 13.620492799999965,
    risberg => 13.771363999999949,
    evertsberg => 13.95615399999997,
    oxberg => 14.173285899999996,
    hokberg => 14.316667000000052,
    eldris => 14.40676,
    mora => 14.537003000000027
};
    
  //  var controlNames2 = {
  //  "Start" => "Start",
  //  "Smågan" => "Smågan",
  //  "Mångsbodarna" => "Mångsbodarna",
  //  "Risberg" => "Risberg",
  //  "Evertsberg" => "Evertsberg",
  //  "Oxberg" => "Oxberg",
  //  "Hökberg" => "Hökberg",
  //  "Eldris" => "Eldris",
  //  "Mora" => "Mora"
//};

 var controlNames = {
    start => start,
    smagan => smagan,
    mangsbodarna => mangsbodarna,
    risberg => risberg,
    evertsberg => evertsberg,
    oxberg => oxberg,
    hokberg => hokberg,
    eldris => eldris,
    mora => mora
};


    
    var posnInfo = null;
    var counter = 0;
    var mLapCertainty = "";
    hidden var mTimerState = STOPPED;
    var locString;
    var currentLongitud = 60.0;
    var currentLatitude = 14.0;
    
    var lastCheckPoint = "";

    function initialize() {
        DataField.initialize();

        var info = Act.getActivityInfo();

        //! If  the activity timer is greater than 0, then we don't know the lap or timer state.
        if( (info.timerTime != null) && (info.timerTime > 0) )
        {
            mLapCertainty = "?";
        }
        
        lastCheckPoint = checkPoints[0];
    }
    
    function checkLocation( lat, long){
       put2(" checkLoc enter", lastCheckPoint );
     
       
       if (lastCheckPoint.equals("")){
           lastCheckPoint = controlNames[start];            
       }else if (lastCheckPoint.equals(controlNames[start])){      
           if (long >= controlLongitudes[smagan]){
              lastCheckPoint = controlNames[smagan];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[smagan])){      
           if (long >= controlLongitudes[mangsbodarna]){
              lastCheckPoint = controlNames[mangsbodarna];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[mangsbodarna])){      
           if (long >= controlLongitudes[risberg]){
              lastCheckPoint = controlNames[risberg];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[risberg])){      
           if (long >= controlLongitudes[evertsberg]){
              lastCheckPoint = controlNames[evertsberg];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[evertsberg])){      
           if (long >= controlLongitudes[oxberg]){
              lastCheckPoint = controlNames[oxberg];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[oxberg])){      
           if (long >= controlLongitudes[hokberg]){
              lastCheckPoint = controlNames[hokberg];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[hokberg])){      
           if (long >= controlLongitudes[eldris]){
              lastCheckPoint = controlNames[eldris];          
           }
       }
       else if (lastCheckPoint.equals(controlNames[eldris])){      
           if (long >= controlLongitudes[mora]){
              lastCheckPoint = controlNames[mora];          
           }
       }
       
       	put2("checkLoc exit", lastCheckPoint);
       
       
       return lastCheckPoint;       
       
    }  
    
   
	(:test)
	function startIsSetAsStartingPoint(logger) {
    	var s = new VasaCoachField();    	
    	
    	var result = s.checkLocation(61.1613853, 13.263015600000017);
    	
    	s.put("startIsSetAsStartingPoint: " + result);
    	
    	return (result.equals(s.controlNames[s.start])); // returning true indicates pass, false indicates failure    	
    	
	}
	
	(:test)
	function dictionariesArePopulated(logger) {
    	var positionView = new VasaCoachField();    
    	System.println(positionView.controlNames);
    	
    	if (!positionView.controlNames[positionView.risberg].equals("Risberg")){
    	    return false;
    	}   
    	if (!positionView.controlNames[positionView.oxberg].equals("Oxberg")){
    	    return false;
    	} 
    	
    	if (!positionView.controlLongitudes[positionView.mora].equals(14.537003000000027)){
    	    return false;
    	} 
    	if (!positionView.controlLongitudes[positionView.evertsberg].equals(13.95615399999997)){
    	    return false;
    	} 
    	   
    	return true;	
    	
	}
	
	(:test)
	function splits(logger) {
    	var positionView = new VasaCoachField();    	
    	
    	var result = positionView.checkLocation(61.09999, 13.45);
    	if (!result.equals(positionView.smagan)){
    	    positionView.put(" Smagan failed:  " + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 13.620492799999965);
    	if (!result.equals(positionView.mangsbodarna)){
    	    positionView.put(" Mangsbodarna failed: " + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 13.771363999999949);
    	if (!result.equals(positionView.risberg)){
    	    positionView.put("Risberg" + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 13.95615399999997);
    	if (!result.equals(positionView.evertsberg)){
    	    positionView.put("Evertsberg" + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 14.173285899999996);
    	if (!result.equals(positionView.oxberg)){
    	    positionView.put("Oxberg" + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 14.316667000000052);
    	if (!result.equals(positionView.hokberg)){
    	    positionView.put("Hokberg" + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 14.40676);
    	if (!result.equals(positionView.eldris)){
    	    positionView.put("Eldris" + result);
    	    return false;
    	}  	
    	result = positionView.checkLocation( 61.07859879999999, 14.537003000000027);
    	if (!result.equals(positionView.mora)){
    	    positionView.put("Mora" + result);
    	    return false;
    	}  	
    	
    	
    	
    	positionView.put(" smagan: 4 ");
    	return true;	
    	
	}
	
	function put(message){
      //   Sys.println(Lang.format("f($1$)", [ message ]));
          Sys.println(message );
    }
    
    function put2(topic, message){
      put(topic + ": " + message);
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
         if (info == null || info.currentLocation == null){
             return;
         }
         
         counter = counter +1 ;
         posnInfo = info.currentLocation;
         
        locString = info.currentLocation.toDegrees();
        currentLongitud = locString[0];
        currentLatitude = locString[1];
        
        checkLocation(currentLatitude, currentLongitud);      
        
        
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
