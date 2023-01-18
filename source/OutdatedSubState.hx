package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";

	private var bgColors:Array<String> = ['#314d7f', '#4e7093', '#70526e', '#594465'];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('week54prototype', 'shared'));
		bg.scale.x *= 1.55;
		bg.scale.y *= 1.55;
		bg.screenCenter();
		add(bg);

		var kadeLogo:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('KadeEngineLogo'));
		kadeLogo.scale.y = 0.3;
		kadeLogo.scale.x = 0.3;
		kadeLogo.x -= kadeLogo.frameHeight;
		kadeLogo.y -= 180;
		kadeLogo.alpha = 0.8;
		add(kadeLogo);

		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			#if mobile
			"Your Kade Engine is outdated!\nYou are on "
			+ MainMenuState.kadeEngineVer
			+ "\nBeacuse this is old port lmfao"
			+ "\n\nTouch Your Screen To Contiune", 32);
			#end
			#if mobileCweb
			"Your Kade Engine is outdated!\nYou are on "
			+ MainMenuState.kadeEngineVer
			+ "\nBeacuse this is old port lmfao"
			+ "\n\nPress ENTER or Touch Your Screen to Contiune", 32);
			#end
			#if desktop
			"Your Kade Engine is outdated!\nYou are on "
			+ MainMenuState.kadeEngineVer
			+ "\nBeacuse this is old port lmfao"
			+ "\n\nPress ENTER to Contiune", 32);
			#end

			txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
			txt.borderColor = FlxColor.BLACK;
			txt.borderSize = 3;
			txt.borderStyle = FlxTextBorderStyle.OUTLINE;
			txt.screenCenter();
			add(txt);

			FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
			FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
				if (colorRotation < (bgColors.length - 1))
					colorRotation++;
				else
					colorRotation = 0;
			}, 0);

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				if (kadeLogo.angle == -10)
					FlxTween.angle(kadeLogo, kadeLogo.angle, 10, 2, {ease: FlxEase.quartInOut});
				else
					FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
			}, 0);

			new FlxTimer().start(0.8, function(tmr:FlxTimer)
			{
				if (kadeLogo.alpha == 0.8)
					FlxTween.tween(kadeLogo, {alpha: 1}, 0.8, {ease: FlxEase.quartInOut});
				else
					FlxTween.tween(kadeLogo, {alpha: 0.8}, 0.8, {ease: FlxEase.quartInOut});
			}, 0);
	}

	override function update(elapsed:Float)
	{
		#if (mobileC || mobileCweb)
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
			if (touch.justPressed)
				justTouched = true;
		#end
		if (controls.ACCEPT #if (mobileC || mobileCweb) || justTouched #end)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
