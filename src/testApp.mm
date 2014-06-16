#include "testApp.h"
#include "ofxPublishScreen.h"

ofxPublishScreen::Subscriber subs;
ofImage image;
bool isDiscovered = false;
//--------------------------------------------------------------
void testApp::setup(){	
	// initialize the accelerometer
    ofSetLogLevel(OF_LOG_VERBOSE);
	ofxAccelerometer.setup();
	
	//If you want a landscape oreintation 
	ofSetOrientation(OF_ORIENTATION_90_LEFT);
	
	ofBackground(127,127,127);
    
    ofAddListener(ofxBonjour::Events().onServicesDiscovered, this, &testApp::discoveredServices);
    ofAddListener(ofxBonjour::Events().onServiceDiscovered, this, &testApp::gotServiceData );
    bonjourClient.discover("_zmq._tcp.");

    
//	subs.setup("10.0.1.1", 20000);
}

//--------------------------------------------------------------
void testApp::update(){
    
	if(isDiscovered)subs.update();
}

//--------------------------------------------------------------
void testApp::draw(){

	if(isDiscovered)subs.draw();
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}
//--------------------------------------------------------------
void testApp::discoveredServices( vector<NSNetService*> & services ){
    for (int i=0; i<services.size(); i++){
        ofLogVerbose(__PRETTY_FUNCTION__)<< [services[i].description cStringUsingEncoding:NSUTF8StringEncoding] << endl;
    }
}

//--------------------------------------------------------------
void testApp::gotServiceData( Service & service ){
    ofLogVerbose(__PRETTY_FUNCTION__)<< service.ipAddress << ":" << service.port << endl;
    if(service.ipAddress!="0.0.0.0" && !isDiscovered)
    {
        subs.setup(service.ipAddress , 20000);
        isDiscovered = true;
    }
}
