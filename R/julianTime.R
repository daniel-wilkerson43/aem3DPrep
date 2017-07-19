julianTime = function(dates, times){
  dates = ymd(dates)
  if(sum(times==0)){
    jTimes=".000"
  }else{
    rjTimes = times/2400
    jTimes = paste(".", as.character(rjTimes*1000), sep = "")
  }
  jYears = format(dates, "%Y")
  jDays = format(dates, "%j")
  julianTime = paste(as.character(jYears), as.character(jDays),
                as.character(jTimes), sep = "")
  return(julianTime)
}
