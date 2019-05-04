# this function will make grid art
# arguments define the number of squares in each dimension (xSize, ySize)
# grout defines the gap between squares (none = 0, max = 1)
# hFactor defines the amount of hysteresis (none = 0, max = 1, moderate = 10)
make_grid_art <- function(xSize, ySize, grout, hFactor) {
  xWave <- seq.int(1:xSize)
  yWave <- seq.int(1:ySize)
  axMin <- min(min(xWave) - 1,min(yWave) - 1)
  axMax <- max(max(xWave) + 1,max(yWave) + 1)
  nSquares <- length(xWave) * length(yWave)
  x <- 0
  halfGrout <- (1 - grout) / 2
  for (i in seq_along(yWave)) {
    yCentre <- yWave[i]
    for (j in seq_along(xWave)) {
      if(hFactor < 1) {
        hyst <- rnorm(8, halfGrout, 0)
      }
      else {
        hyst <- rnorm(8, halfGrout, sin(x / (nSquares - 1) * pi) / hFactor)
      }
      xCentre <- xWave[j]
      lt <- c(xCentre - hyst[1],yCentre - hyst[2])
      rt <- c(xCentre + hyst[3],yCentre - hyst[4])
      rb <- c(xCentre + hyst[5],yCentre + hyst[6])
      lb <- c(xCentre - hyst[7],yCentre + hyst[8])
      new_shape_start <- rbind(lt,rt,rb,lb)
      new_shape_end <- rbind(rt,rb,lb,lt)
      new_shape <- cbind(new_shape_start,new_shape_end)
      if(i == 1 && j == 1) {
        multiple_segments <- new_shape
      } else {
        multiple_segments <- rbind(multiple_segments,new_shape)
      }
      x <- x + 1
    }
  }
  par(mar = c(0,0,0,0))
  plot(0, 0,
       xlim=c(axMin,axMax),
       ylim=c(axMax,axMin),
       col = "white", xlab = "", ylab = "", axes=F, asp = 1) 
  segments(x0 = multiple_segments[,1],
           y0 = multiple_segments[,2],
           x1 = multiple_segments[,3],
           y1 = multiple_segments[,4])
}
# square grid with minimal hysteresis
make_grid_art(10,10,0.2,50)
# square grid (more squares) more hysteresis
make_grid_art(20,20,0.2,10)
# rectangular grid same hysteresis
make_grid_art(25,15,0.2,10)
# same grid with no hysteresis
make_grid_art(25,15,0.2,0)
# square grid moderate hysteresis and no grout
make_grid_art(20,20,0,10)
