import Foundation

class MainScene: CCNode {
  
  var ball:CCNodeColor!
  var player:CCNodeColor!
  var cpu:CCNodeColor!
  var latestTouchLocation:CGPoint?
  
  let cpuPointsPerSecond:Double = 200
  
  override func onEnterTransitionDidFinish() {
    super.onEnterTransitionDidFinish()
    
    self.userInteractionEnabled = true
    player.physicsBody.type = .Kinematic
    cpu.physicsBody.type = .Kinematic
    
    startGame()
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
  
  override func fixedUpdate(delta: CCTime) {
    // cpu movement
    if (ball.position.y < cpu.positionInPoints.y) {
      cpu.positionInPoints = CGPoint(x: cpu.positionInPoints.x, y: cpu.positionInPoints.y - CGFloat(delta * cpuPointsPerSecond))
    } else if (ball.position.y > cpu.positionInPoints.y) {
      cpu.positionInPoints = CGPoint(x: cpu.positionInPoints.x, y: cpu.positionInPoints.y + CGFloat(delta * cpuPointsPerSecond))
    }
    
    if ( (CGRectGetMaxX(ball.boundingBox()) < 0) || CGRectGetMinX(ball.boundingBox()) > self.contentSizeInPoints.width ){
      startGame()
    }
  }
  
  func startGame() {
    ball.position = CGPoint(x: self.contentSizeInPoints.width / 2, y: self.contentSizeInPoints.height / 2)
    let xImpulse = 40
    let yImpulse = 40
    let impulse = CGPoint(x: xImpulse, y: yImpulse)
    ball.physicsBody.applyImpulse(impulse)
  }
  
}
