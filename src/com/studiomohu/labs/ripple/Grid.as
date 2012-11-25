package com.studiomohu.labs.ripple 
{
	import com.studiomohu.core.util.Spy;

	import flash.display.Sprite;

	/**
	 * @author art
	 */
	public class Grid extends Sprite 
	{
		private var colArray : Array;
		private var itemHolder : Sprite;

		public function Grid ()
		{
			itemHolder = new Sprite( );
			addChild( itemHolder );
		}

		public function init ( itemSize : int, spacing : int, cols : int, rows : int, color : int, alpha : Number, gridRenderType : String ) : void
		{
			var i : int = 0;
			var j : int = 0;
			var item : GridItem;
			
			var rowArray : Array;
			var n : int = 0;
			colArray = new Array( );
			
			for (; i < cols ; i++)
			{
				j = 0;
				rowArray = new Array( );
				for(; j < rows ; j++)
				{
					item = new GridItem( itemSize, color, alpha, i, j, gridRenderType );
					itemHolder.addChild( item );
					item.addEventListener( GridEvent.HIT, onGridHit, false, 0, true );
					item.x = (spacing + itemSize) * i;
					item.y = (spacing + itemSize) * j;
					rowArray.push( item );
					n++; 
				}
				colArray.push( rowArray );
			}
		}

		public function clear () : void
		{
			Spy.info( this, "clear" );
			var i : int = 0;
			var j : int = 0;
			var item : GridItem;
			
			var rowArray : Array;
			if( colArray )
			{
				var l : int = colArray.length;
				for (; i < l ; i++)
				{
					rowArray = colArray[i];
					j = 0;
					for(; j < rowArray.length ; j++)
					{
						item = rowArray[j];
						itemHolder.removeChild( item );
						item.removeEventListener( GridEvent.HIT, onGridHit );
						item = null;
					}
				}
			}
		}

		public function setPixel ( xCoord : int, yCoord : int, val : Number ) : void
		{
			var item : GridItem = getPixelGridBox( xCoord, yCoord );
			item.val = val;
		}

		public function getPixelGridBox ( xCoord : int, yCoord : int ) : GridItem
		{
			var item : GridItem = colArray[xCoord][yCoord] as GridItem;
			return item;
		}

		private function onGridHit ( e : GridEvent ) : void
		{
			dispatchEvent( e.clone( ) );
		}
	}
}
