package khajak.particles;
import kha.Color;
import kha.Image;
import kha.math.FastMatrix4;
import kha.math.FastVector2;
import kha.math.FastVector3;
import kha.math.Random;

class Particle {

	public var position: FastVector3;
	private var direction: FastVector3;
	private var speedStart: Float;
	private var speedEnd: Float;
	private var gravity: FastVector3;
	private var affectedByGravity: Bool;
	
	private var timeToLive: Float;
	private var timeToLiveOverall: Float;
	public var size: FastVector2;
	public var rotData: FastVector2;
	public var color: Color;
	public var texture: Image;
	public var mesh: Mesh;
	
	public var model: FastMatrix4;
	
	public function new(position: FastVector3, angle: Float, direction: FastVector3, speedStart: Float, speedEnd: Float, affectedByGravity: Bool, timeToLive: Float, size: FastVector2, color: Color, texture: Image) {
		this.position = position;
		this.direction = direction;
		this.speedStart = speedStart;
		this.speedEnd = speedEnd;
		this.gravity = new FastVector3(0, 0, 0);
		this.affectedByGravity = affectedByGravity;
		this.timeToLive = timeToLive;
		timeToLiveOverall = timeToLive;
		this.size = size;
		this.rotData = new FastVector2(Math.sin(angle), Math.cos(angle));
		this.color = color;
		this.texture = texture;
		this.mesh = Meshes.Billboard;
		
		model = FastMatrix4.translation(position.x, position.y, position.z);
	}
	
	public function update(deltaTime: Float): Bool {
		timeToLive -= deltaTime;
		
		var speed = speedEnd + (speedStart - speedEnd) * (timeToLive / timeToLiveOverall);
		var movement = direction.mult(speed);
		if (affectedByGravity) {
			gravity = gravity.add(new FastVector3(0, -0.5 * 9.81 * deltaTime, 0));
		}
		position = position.add(movement.add(gravity).mult(deltaTime));
		model = FastMatrix4.translation(position.x, position.y, position.z);
		
		return timeToLive >= 0;
	}
}