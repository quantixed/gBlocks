#pragma TextEncoding = "MacRoman"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

////	@param	num	number of points to be generated
Function UniformCircle(num)
	Variable num
 
	Make/O/N=(num) xw,yw
	Variable tt,uu,rr
 
	Variable i
 
	for(i = 0; i < num; i += 1)
		tt = 2 * pi * (0.5 + enoise(0.5))
		uu = (0.5 + enoise(0.5)) + (0.5 + enoise(0.5))
		if(uu > 1)
			rr = 2 - uu
		else
			rr = uu
		endif
		xw[i] = rr * cos(tt)
		yw[i] = rr * sin(tt)
	endfor
	DoWindow/K resultPlot
	Display/N=resultPlot yw vs xw
	ModifyGraph/W=resultPlot mode=3,marker=8
	ModifyGraph/W=resultPlot width={Plan,1,bottom,left}
End

Function FindAndPlotNearest()
	WAVE/Z xW, yW
	Variable nPoints = numpnts(xW)
	Make/O/N=(nPoints*3,2) resW
	
	Variable i
	
	Variable xx,yy
	
	for(i = 0; i < nPoints; i += 1)
		xx = xW[i]
		yy = yW[i]
		resW[i*3][0] = xx
		resW[i*3][1] = yy
		MatrixOP/O/FREE tempW = sqrt(((xW - xx) * (xW - xx)) + ((yW - yy) * (yW - yy)))
		tempW[i] = 100
		WaveStats/Q tempW
		
		xx = xW[V_minLoc]
		yy = yW[V_minLoc]
		resW[(i*3)+1][0] = xx
		resW[(i*3)+1][1] = yy
		resW[(i*3)+2][0] = NaN
		resW[(i*3)+2][1] = NaN
	endfor
	DoWindow/K newresultPlot
	Display/N=newresultPlot resW[][1] vs resW[][0]
	ModifyGraph/W=newresultPlot rgb=(65535,0,0,32767), lsize=2
	ModifyGraph/W=newresultPlot width={Plan,1,bottom,left}
End
