
# This file is a generated template, your changes will not be overwritten

histogramClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "histogramClass",
    inherit = histogramBase,
    private = list(
        .run = function() {
            ### getData
            var <- paste (self$options$var)
            mydata <- select(self$data, c(var))
            mydata <- sapply(mydata, as.numeric)
            mydata <- data.frame(var= mydata)
            colnames(mydata)[1] <- "var"

            ### Error Check
            Err <- NULL
            if(self$options$lowerBound>=self$options$upperBound){
                Err <- 'The lower Bound must be lower than the upper bound'
            }
            if(self$options$widthBinsN<=0){
                Err <- 'Binwidth must be positive'
            }
            if(self$options$numBinsN<=0 || typeof(self$options$numBinsN)!='integer'){
                Err <- 'Number of Bins must be a positive Integer'
            }
            if(!(is.null(Err))){
                self$results$hist$setVisible(visible=FALSE)
                jmvcore::reject(Err)
            }

            ### get specifics
            # bounds
            if(self$options$bounds == "format"){
                lower <- min(mydata[1])
                upper <- max(mydata[1])
            }else if(self$options$bounds == "man"){
                lower <- self$options$lowerBound
                upper <- self$options$upperBound
            }
            if (is.na(lower))
                lower <- 0
            if (is.na(upper))
                upper <- 0

            # set breaks
            offSet <-0 #not necessary so far
            range <- upper - lower 
            length <- nrow(mydata)
            binWidth <- 1 
            if(self$options$bins == 'breakBins'){
                breaks <- as.numeric(unlist(strsplit(self$options$breakBinsN, split=",")))
            }else{
                if(self$options$bins == 'widthBins'){
                    binWidth <- self$options$widthBinsN
                }else if(self$options$bins == 'numBins'){
                    binWidth <- range/(self$options$numBinsN-offSet) 
                }else if(self$options$bins == 'ruleBins' & self$options$ruleBinsN == "sqrtN"){
                    binWidth <- range/(sqrt(length)-offSet)
                }else if(self$options$bins == 'ruleBins' & self$options$ruleBinsN == 'logN'){
                    binWidth <- range/((10*log(length,base=10))-offSet)
                }
                #for another possibility
                #breaks <- c(min(data[1]),seq(lower,upper,by=binWidth),max(data[1]))
                breaks <- seq(lower,upper,by=binWidth)
                if(breaks[length(breaks)]< upper) breaks <- c(breaks, upper)
            }
            # proportionality factor
            propFactor <- 1
            ylabel <- "proportion"
            if(self$options$count == 'abs'){
                propFactor <- length(mydata[1])
                ylabel <- "count"
            }

            ###prepare plotdata
            plotData <- mydata
            image <- self$results$hist #set plotData
            image$setState(list(data=plotData, xlabel=var,ylabel=ylabel, breaks=breaks, propFactor=propFactor))

        },
        .histogram=function(image, ggtheme, theme, ...) {
            if (is.null(image$state))
                return(FALSE)

            data <- image$state$data
            breaks <- image$state$breaks
            xlabel <- image$state$xlabel
            ylabel <- image$state$ylabel
            propFactor <- image$state$propFactor
            fill <- theme$fill[2]
            color <- theme$color[1]
            
            # Do the plot
            plot <- ggplot(data) + xlab(xlabel) + ylab(ylabel) + ggtheme[[1]]  +
                geom_histogram(aes(x=var, y = ..density..*propFactor),breaks=breaks, color=color, fill=fill)
            print(plot)
            TRUE
        })
)
