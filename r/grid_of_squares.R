xWave <- seq.int(1:10)
yWave <- seq.int(1:10)

for (i in seq_along(xWave)) {
  xCentre <- xWave[i]
  for (j in seq_along(yWave)) {
    yCentre <- yWave[j]
    lt <- c(xCentre - 0.4,yCentre - 0.4)
    rt <- c(xCentre + 0.4,yCentre - 0.4)
    rb <- c(xCentre + 0.4,yCentre + 0.4)
    lb <- c(xCentre - 0.4,yCentre + 0.4)
    new_shape_start <- rbind(lt,rt,rb,lb)
    new_shape_end <- rbind(rt,rb,lb,lt)
    new_shape <- cbind(new_shape_start,new_shape_end)
    if(i == 1 && j == 1) {
      multiple_segments <- new_shape
    } else {
      multiple_segments <- rbind(multiple_segments,new_shape)
    }
  }
}
par(pty="s")
plot(0, 0,
     xlim=c(min(xWave)-1,max(xWave)+1),
     ylim=c(min(yWave)-1,max(yWave)+1),
     col = "white", xlab = "", ylab = "", axes=F) 
segments(x0 = multiple_segments[,1],
         y0 = multiple_segments[,2],
         x1 = multiple_segments[,3],
         y1 = multiple_segments[,4])

