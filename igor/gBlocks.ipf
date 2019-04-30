#pragma TextEncoding = "MacRoman"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

///	@param	size	size of square array (whole units)
Function MakeArray(size)
	Variable size
	
	Make/O/N=(size,size) matX,matY
	matX = p + gnoise(0.1)
	maty = q + gnoise(0.1)
	Concatenate/O {matx,matY}, matA
	Redimension/E=1/N=(size^2,2) matA
	KillWindow/Z result
	Display/N=result/W=(50,50,650,650) matA[][1] vs matA[][0]
	ModifyGraph/W=result margin=5,width={Plan,1,bottom,left}
	ModifyGraph mode=3,marker=16,mrkThick=0
	// make size
	Make/O/N=(size^2) sizeW = 5 + enoise(5)
	ModifyGraph/W=result zmrkSize(matA)={sizeW,*,*,1,10}
	// make color
	Make/O/N=(size^2,4) colorW=0
	colorW[][3] = 65535/2 + 65535*enoise(0.5)
	ModifyGraph/W=result zColor(matA)={colorW,*,*,directRGB,0}
	Make/FREE/N=(size^2) redW = enoise(1) - 0.9
	Variable i
	
	for(i = 0; i < size^2; i += 1)
		if(redW[i] > 0)
			colorW[i][0] = 65535
		endif
	endfor
End

Function MakeGenBlocks(nFrames,size)
	Variable nFrames,size
	
	// Define Paths for OutputTIFFFolder
	NewPath/C/O/Q/Z OutputTIFFFolder

	String iString, tiffName
	
	Variable i
	
	for(i = 0; i < nFrames; i += 1)
		MakeArray(size)
		// take snap
		DoWindow/F Result

		if( i >= 0 && i < 10)
			iString = "000" + num2str(i)
		elseif( i >=10 && i < 100)
			iString = "00" + num2str(i)
		elseif(i >= 100 && i < 1000)
			iString = "0" + num2str(i)
		elseif(i >= 1000 && i < 10000)
			iString = num2str(i)
		endif
		tiffName = "gen" + iString + ".tif"
		SavePICT/O/P=OutputTIFFFolder/E=-7/B=576 as tiffName
	endfor
End