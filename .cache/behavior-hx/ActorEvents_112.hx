package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class ActorEvents_112 extends ActorScript
{
	public var _draw:Bool;
	public var _colliding:Bool;
	public var _transformed:Bool;
	public var _draw2:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("draw", "_draw");
		_draw = false;
		nameMap.set("colliding", "_colliding");
		_colliding = false;
		nameMap.set("transformed", "_transformed");
		_transformed = false;
		nameMap.set("draw2", "_draw2");
		_draw2 = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_draw = false;
		_draw2 = false;
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("Action 1", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if((_transformed == true))
				{
					_draw = true;
					runLater(1000 * 1, function(timeTask:TimedTask):Void
					{
						_draw = false;
						Engine.engine.setGameAttribute("meatPicked", true);
						recycleActor(actor);
					}, actor);
				}
				else
				{
					if(_colliding)
					{
						_draw2 = true;
						actor.setAnimation("meat");
						_transformed = true;
						runLater(1000 * 1, function(timeTask:TimedTask):Void
						{
							_draw2 = false;
						}, actor);
					}
				}
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(112).ID, getActorType(0).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_colliding = true;
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_draw == true))
				{
					g.translateToScreen();
					g.fillColor = Utils.convertColor(Utils.getColorRGB(255,255,255));
					g.fillRect(0, 200, 500, 100);
					g.drawString("" + "    The meat was added to your inventory", 0, 200);
				}
				if((_draw2 == true))
				{
					g.translateToScreen();
					g.fillColor = Utils.convertColor(Utils.getColorRGB(255,255,255));
					g.fillRect(0, 200, 500, 100);
					g.drawString("" + "    Mooo", 0, 200);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}