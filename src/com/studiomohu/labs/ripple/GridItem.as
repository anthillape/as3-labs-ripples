package com.studiomohu.labs.ripple
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.studiomohu.labs.generic.LabsColors;
	import com.studiomohu.core.util.Spy;

	import flash.display.Sprite;

	/**
	 * @author art
	 */
	public class GridItem extends Sprite 
	{
		private var hit : Sprite;
		private var bg : Sprite;
		
		private var _xCoord : int;		private var _yCoord : int;
		private var size : int;
		private var color : int;
		private var _val : Number = .5;
		private var _renderMode : String;
		private var _damping : Boolean = true;
		public static const ALPHA_SQUARE : String = "alpha square";		public static const CIRCLE_SIZE : String = "circle size";		public static const DIRECTION : String = "direction";
		public var non : Boolean = false;
		

		public function GridItem ( size : int, color : int, alpha : Number, xCoord : int, yCoord : int, renderMode : String )
		{
			this.size = size;
			this.color = color;
			this.alpha = alpha;
			this._renderMode = renderMode;
			bg = new Sprite( );
			hit = new Sprite( );
			addChild( bg );			addChild( hit );
			bg.graphics.clear( );
			bg.graphics.beginFill( color );
			switch( _renderMode )
			{
				case ALPHA_SQUARE : 
					bg.graphics.drawRect( 0, 0, size, size );
					break;
				case CIRCLE_SIZE : 
					bg.graphics.drawCircle( 0, 0, size/2 );
					bg.x = bg.y = size / 2;
					break;
				case DIRECTION : 
					bg.graphics.drawEllipse( 0, 0, size / 4, size/2 );
					break;
			}
			
			bg.graphics.endFill( );
			hit.graphics.clear( );
			hit.graphics.beginFill( 0, 0 );
			hit.graphics.drawRect( 0, 0, size, size );
			hit.graphics.endFill( );
			_xCoord = xCoord;
			_yCoord = yCoord;
			this.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
		}

		public function set val ( n : Number ) : void
		{
			if( _damping )
			{
				if(this._xCoord == 1)
				{
					if(this._yCoord == 1)
					{
						if(!non)
						{
							if( n )
							{
							//Spy.info( this, "v : " + this._val );							//Spy.info( this, "n : " + n );
							non = true;
							}
						}
					}
				}
				var d : Number = n - this._val;
				this._val += d * .5;
				
			}
			else
			{
				this._val = n;
			}
			render( );
		}
		
		public function set damping ( b : Boolean ) : void
		{
			this.damping = b;
		}

		public function set renderMode ( s : String ) : void
		{
			this._renderMode = s;
		}
		
		public function get damping () : Boolean
		{
			return this._damping;
		}

		public function get val () : Number
		{
			return this._val;
		}

		public function get xCoord () : int
		{
			return _xCoord;
		}

		public function get yCoord () : int
		{
			return _yCoord;
		}

		private function render () : void
		{
			switch( _renderMode )
			{
				case ALPHA_SQUARE : 
					setColor( LabsColors.COLORED, this._val );
					break;
				case CIRCLE_SIZE : 
					setSize( this._val );
					break;
				case DIRECTION : 
					setDirection( this._val );
					break;
			}
		}
		
		private function setColor ( color : int, alpha : Number ) : void
		{
			this.alpha = alpha;
			this.color = color;
			bg.graphics.clear( );
			bg.graphics.beginFill( color );
			bg.graphics.drawRect( 0, 0, size, size );
			bg.graphics.endFill( );
		}

		private function setSize ( n : Number ) : void
		{
			bg.scaleX = bg.scaleY = n * 2;
			//bg.x = bg.y = -size / 2 * n;
		}
		
		private function setDirection ( n : Number) : void
		{
			bg.rotation = n * 720;
		}

		private function onMouseOver ( e : MouseEvent ) : void
		{
			dispatchEvent( new GridEvent( GridEvent.HIT, _xCoord, _yCoord ) );
		}
	}
}
