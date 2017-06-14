#pragma TextEncoding = "MacRoman"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

// First part of this code is to make hexagonal array with centres as points in a 2D wave

///	@param	arraySize	size of square array (whole units)
///	@param	hexSize	size of hexagon (centre to any corner)
///	@param	hexOpt	pointy-topped = 0, flat-topped = 1
///	@param	rowOpt	even row left = 0, even row right = 1
///	@param	exclOpt	square array = 0, constrain to circle = 1
Function MakeArray(arraySize,hexSize,hexOpt,rowOpt,exclOpt)
	Variable arraySize,hexSize,hexOpt,rowOpt,exclOpt
	
	Variable height = hexSize * 2
	Variable vert = height * (3/4)
	Variable width = sqrt(3)/2 * height
	Variable horiz = width
	Variable midPQ = arraySize / 2
	Variable centX,centY // centre of array
	
	Make/O/N=(arraySize,arraySize) matX,matY
	
	if(hexOpt == 0)
		if(rowOpt == 0)
		// hexOpt = 0, rowOpt = 0
		// 0,0 is 1w,0.5h; 1,0 is 0.5w,1.25h
		matX = (1 * width) + (p * width) - (mod(q,2) * 0.5 * width)
		matY = (0.5 * height) + (q * vert)
		centX = (1 * width) + (midPQ * width) - (mod(midPQ,2) * 0.5 * width)
		centY = (0.5 * height) + (midPQ * vert)
		else
		// hexOpt = 0, rowOpt = 1
		// 0,0 is 0.5w,0.5h; 1,0 is 1w,1.25h
		matX = (0.5 * width) + (p * width) + (mod(q,2) * 0.5 * width)
		matY = (0.5 * height) + (q * vert)
		centX = (0.5 * width) + (midPQ * width) + (mod(midPQ,2) * 0.5 * width)
		centY = (0.5 * height) + (midPQ * vert)
		endif
	else
		if(rowOpt == 0)
		// hexOpt = 1, rowOpt = 0
		// 0,0 is 1.25w,0.5h; 1,0 is 0.5w,1h
		matX = (1.25 * width) + (p * width)
		matY = (0.5 * height) + (q * vert) - (mod(p,2) * 0.5 * height)
		centX = (1.25 * width) + (midPQ * width)
		centY = (0.5 * height) + (midPQ * vert) - (mod(midPQ,2) * 0.5 * height)
		else
		// hexOpt = 1, rowOpt = 1
		// 0,0 is 0.5w,0.5h; 1,0 is 1w,1.25h
		matX = (0.5 * width) + (p * width)
		matY = (0.5 * height) + (q * vert) + (mod(p,2) * 0.5 * height)
		centX = (0.5 * width) + (midPQ * width)
		centY = (0.5 * height) + (midPQ * vert) + (mod(midPQ,2) * 0.5 * height)
		endif
	endif
	
	Variable dist = min(centX,centY)
	// do exclusion
	if(exclOpt == 1)
		matX = (sqrt( (matX[p][q] - centX)^2 + (matY[p][q] - centY)^2) < dist ) ? matX[p][q] : NaN
		matY = (sqrt( (matX[p][q] - centX)^2 + (matY[p][q] - centY)^2) < dist ) ? matY[p][q] : NaN
	endif
	Concatenate/O/KILL {matx,matY}, matA
	Redimension/E=1/N=(arraySize^2,2) matA
	// Add noise to coords
	matA += gnoise(0.1)
	
	KillWindow/Z result
	Display/N=result/W=(50,50,650,650) matA[][1] vs matA[][0]
	ModifyGraph/W=result margin=5,width={Plan,1,bottom,left}
	ModifyGraph/W=result mode=3,marker=19,mrkThick=0
	ModifyGraph/W=result noLabel=2,axThick=0,standoff=0
	// make size
	Make/O/N=(arraySize^2) sizeW = 5 + enoise(5)
	ModifyGraph/W=result zmrkSize(matA)={sizeW,*,*,1,10}
	// make color
	Make/O/N=(arraySize^2,4) colorW=0
	colorW[][3] = 65535/2 + 65535*enoise(0.5)
	ModifyGraph/W=result zColor(matA)={colorW,*,*,directRGB,0}
	Make/FREE/N=(arraySize^2) redW = enoise(1) - 0.9
	Variable i
	
	for(i = 0; i < arraySize^2; i += 1)
		if(redW[i] > 0)
			colorW[i][0] = 65535
		endif
	endfor
End
