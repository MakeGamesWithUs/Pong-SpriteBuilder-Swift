import Foundation

class MainScene: CCNode {
  
  var ball:CCNodeColor!
  var player:CCNodeColor!
  var cpu:CCNodeColor!
  var latestTouchLocation:CGPoint?
  
  override func onEnterTransitionDidFinish() {
    super.onEnterTransitionDidFinish()
    
    let xImpulse = 40
    let yImpulse = 40
    let impulse = CGPoint(x: xImpulse, y: yImpulse)
    ball.physicsBody.applyImpulse(impulse)
    
    self.userInteractionEnabled = true
    player.physicsBody.type = .Kinematic
    cpu.physicsBody.type = .Kinematic
  }
  
  override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
    latestTouchLocation = touch.locationInNode(self)
  }
  
  override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
    let touchLocation = touch.locationInNode(self)
    let yDistance = touchLocation.y - latestTouchLocation!.y
    
    player.positionInPoints.y += yDistance
    latestTouchLocation = touchLocation
  }
}
