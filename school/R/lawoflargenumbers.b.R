
lawOfLargeNumbersClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "lawOfLargeNumbersClass",
    inherit = lawOfLargeNumbersBase,
    private = list(
        .run = function() {
            
            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)
            set.seed(0)
            if(self$options$throw == 'c1'){
                a <- c(0:1)
                p <- c(0.5,0.5)
                mean <- 0.5
            }else if(self$options$throw == 'c2'){
                a <- c(0:1)
                p <- c(0.4,0.6)
                mean <- 0.5
            }else if(self$options$throw == 'd1'){
                a <- c(1:6)
                p <- c(1/6,1/6,1/6,1/6,1/6,1/6) 
                mean <- 3.5
            }else {
                a <- c(1:6)
                p <- c(1/12,1/12,1/12,1/12,1/3,1/3)
                mean <- 3.5
            }
            if(self$options$num > 10000 || self$options$num <1){
                self$results$warning$setVisible(TRUE)
                return(FALSE)
            }else{
                N <- self$options$num
            }
            min <- min(a)
            max <- max(a)

            x <- seq(1,N,by=1)
            numbers <- sample(a,N, replace = TRUE, prob = p)
            mydata <- numeric(N)
            for (i in 1:N) {
                mydata[i] <- sum(numbers[0:i])/i
            }
            
            
            #set plotData
            plotData <- data.frame(x = x, y = mydata)
            colnames(plotData)[1] <- "x"
            colnames(plotData)[2] <- "y"
            image <- self$results$loln 
            image$setState(list(data=plotData, min=min, max=max, mean=mean))
            
        },
        .lawoflargenumbers = function(image, ggtheme, theme, ...){
            if (is.null(image$state))
                return(FALSE)
            data <- image$state$data
            fill <- theme$fill[2]
            color <- theme$color[1]

            min <- image$state$min #min(data[2])
            if (is.na(min))
                min <- 0
            max <- image$state$max #max(data[2])
            if (is.na(max))
                max <- 0
            mean <- image$state$mean 
            range <- max - min 
            length <- nrow(data)
            nUniques <- length(unique(data[1]))

            plot <- ggplot(data, aes(x=x, y=y)) +
                xlab("no. of trials") +
                ylab("averages") + 
                ggtheme[[1]] +
                geom_line(color=color) +
                #geom_point() +
                ylim(min, max)
                #scale_x_log10( breaks=c(1,5,10,15,20,50,100), limits=c(1,1000) )         
            if(self$options$theoMean){
                plot <- plot + geom_hline(yintercept = mean, color="blue")
            }
            print(plot)
            TRUE
        })
)
