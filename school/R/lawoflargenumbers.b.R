
lawOfLargeNumbersClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "lawOfLargeNumbersClass",
    inherit = lawOfLargeNumbersBase,
    private = list(
        .run = function() {
            ###get specifics
                throw <- self$options$throw
                switch(throw,
                    c1={
                        a <- c(0:1)
                        p <- c(0.5,0.5)
                        mean <- 0.5
                    },c2={
                        a <- c(0:1)
                        p <- c(0.4,0.6)
                        mean <- 0.5
                    },d1={
                        a <- c(1:6)
                        p <- c(1/6,1/6,1/6,1/6,1/6,1/6) 
                        mean <- 3.5
                    },d2={
                        a <- c(1:6)
                        p <- c(1/12,1/12,1/12,1/12,1/3,1/3)
                        mean <- 3.5
                    }
                )
                if(self$options$num > 10000 || self$options$num <1){
                    self$results$loln$setVisible(visible=FALSE)
                    jmvcore::reject('Error! Wrong number of trials')
                }else{
                    N <- self$options$num
                }
                min <- min(a)
                if (is.na(min)) min <-0
                max <- max(a)
                if (is.na(max)) max <- 0


            ###Create Sample Data
                #Set Random Seed 
                set.seed(0)
                x <- seq(1,N,by=1)
                numbers <- sample(a,N, replace = TRUE, prob = p) #sample
                mydata <- numeric(N)
                for (i in 1:N) {
                    mydata[i] <- sum(numbers[0:i])/i
                }
            
            
            ###set plotData
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
            color <- theme$color[1]
            min <- image$state$min 
            max <- image$state$max 
            mean <- image$state$mean 

            plot <- ggplot(data, aes(x=x, y=y)) +
                xlab("no. of trials") + ylab("averages") + ggtheme[[1]] +
                geom_line(color=color) +
                ylim(min, max)
            if(self$options$theoMean){
                plot <- plot + geom_hline(yintercept = mean, color="blue")
            }
            print(plot)
            TRUE
        })
)
