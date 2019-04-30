xWave <- seq.int(1:10)
yWave <- seq.int(1:10)
x <- 0
nSquares <- length(xWave) * length(yWave)
for (i in seq_along(yWave)) {
  yCentre <- yWave[i]
  for (j in seq_along(xWave)) {
    hyst <- rnorm(8, 0.4, sin(x / (nSquares - 1) * pi) / 10)
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
par(pty="s")
plot(0, 0,
     xlim=c(min(xWave)-1,max(xWave)+1),
     ylim=c(max(yWave)+1,min(yWave)-1),
     col = "white", xlab = "", ylab = "", axes=F) 
segments(x0 = multiple_segments[,1],
         y0 = multiple_segments[,2],
         x1 = multiple_segments[,3],
         y1 = multiple_segments[,4])

