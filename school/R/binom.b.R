
# This file is a generated template, your changes will not be overwritten

binomClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "binomClass",
    inherit = binomBase,
    private = list(
    .run = function() {

        ### 1.1 Preparation ###
        
        # The specification of the first distribution plots parameters n (Size) are extracted
        n1 <- self$options$n1
        n2 <- self$options$n2
        n3 <- self$options$n3
        # The specification of the firsts distribution plot parameter p (Probability) is extracted
        p <- self$options$p

        # The specification of the second distribution plots parameter n (Size) is extracted
        n <- self$options$n
        # The specification of the firsts distribution plot parameters p (Probability) are extracted
        p1 <- self$options$p1
        p2 <- self$options$p2
        p3 <- self$options$p3
             
       
        ### 1.2 Calculations ###

        ##First Plot
        #get scale length
        m <- max(c(n1,n2,n3))
        x <- 0:m
        # Calculation of the distribution density
        density1 <- dbinom(x, n1, p)
        density2 <- dbinom(x, n2, p)
        density3 <- dbinom(x, n3, p)
        meanP1 <- c(n1*p, n2*p, n3*p)
        meanHeightP1 <- c(dbinom(round(n1*p,0), n1, p),dbinom(round(n2*p,0), n2, p),dbinom(round(n3*p,0), n3, p))
        stdP1 <- c(sqrt(n1*p*(1-p)),sqrt(n2*p*(1-p)),sqrt(n3*p*(1-p)))

        #all in one list -> so later we can do fill=group in ggplot
        densityP1 <- c(density1,density2,density3)
        groupP1 <- c(rep(paste(n1),(m+1)),rep(paste(n2),(m+1)),rep(paste(n3),(m+1)))    

        ##Second Plot
        #get scale length
        y <- 0:n
        # Calculation of the distribution density
        density4 <- dbinom(y, n, p1)
        density5 <- dbinom(y, n, p2)
        density6 <- dbinom(y, n, p3)
        meanP2 <- c(n*p1,n*p2,n*p3)
        meanHeightP2 <- c(dbinom(round(n*p1,0), n, p1),dbinom(round(n*p2,0), n, p2),dbinom(round(n*p3,0), n, p3))

        stdP2 <- c(sqrt(n*p1*(1-p1)),sqrt(n*p2*(1-p2)),sqrt(n*p3*(1-p3)))

        #all in one list -> so later we can do fill=group in ggplot
        densityP2 <- c(density4,density5,density6)
        groupP2 <- c(rep(paste(p1),(n+1)),rep(paste(p2),(n+1)),rep(paste(p3),(n+1)))     

         ### 1.3 Create Value Tables ###
        valueTable1 <- self$results$valueTable1
        valueTable2 <- self$results$valueTable2
        if(self$options$mean){
            valueTable1$addColumn(name= "meanCol",title="Mean",type="text")
            valueTable2$addColumn(name= "meanCol",title="Mean",type="text")
        }
        if(self$options$std){
            valueTable1$addColumn(name= "stdCol",title="Standard Deviation",type="text")
            valueTable2$addColumn(name= "stdCol",title="Standard Deviation",type="text")
        }

        valueTable1$setRow(rowNo=1, values=list(sizeCol=n1,probCol=p,meanCol=meanP1[1],stdCol=stdP1[1]))
        valueTable1$setRow(rowNo=2, values=list(sizeCol=n2,probCol=p,meanCol=meanP1[2],stdCol=stdP1[2]))
        valueTable1$setRow(rowNo=3, values=list(sizeCol=n3,probCol=p,meanCol=meanP1[3],stdCol=stdP1[3]))

        valueTable2$setRow(rowNo=1, values=list(sizeCol=n,probCol=p1,meanCol=meanP2[1],stdCol=stdP2[1]))
        valueTable2$setRow(rowNo=2, values=list(sizeCol=n,probCol=p2,meanCol=meanP2[2],stdCol=stdP2[2]))
        valueTable2$setRow(rowNo=3, values=list(sizeCol=n,probCol=p3,meanCol=meanP2[3],stdCol=stdP2[3]))
        
        ### 1.4 Plot Preparation ###
        # Frame Data
        plotData <- data.frame(var = x, density= densityP1, group =groupP1)
        plotData2 <- data.frame(var = y, density= densityP2, group =groupP2)

        # Adjust Labels
        #colnames(plotData) <- c("var","density","group")
        #colnames(plotData2) <- c("var","density","group")

        # Set Data to Image 
        image1 <- self$results$binomPlot1
        image1$setState(list(data=plotData, label="n = ", mean = meanP1, meanHeight = meanHeightP1, std=stdP1))

        image2 <- self$results$binomPlot2
        image2$setState(list(data=plotData2, label="p = ", mean = meanP2, meanHeight = meanHeightP2, std=stdP2))

        ### 1.5 Error Messages ###
        #Error if any p not in [0,1]
        nErr <- FALSE
        pErr <- FALSE
        if(n<0||n>10000){
            self$results$binomPlot2$setVisible(FALSE)
            nErr <- TRUE
        }
        if(p1<0||p1>1||p2<0||p2>1||p3<0||p3>1){
            self$results$binomPlot2$setVisible(FALSE)
            pErr <- TRUE
        } 
        if(p<0||p>1){
            self$results$binomPlot1$setVisible(FALSE)
            pErr <- TRUE
        }
        if(n1<0||n1>10000||n2<0||n2>10000||n3<0||n3>10000) {
            self$results$binomPlot1$setVisible(FALSE)
            nErr <- TRUE
        }
        if(nErr){jmvcore::reject('Size must be between 0 and 10000')}
        if(pErr){jmvcore::reject('Probability must be between 0 and 1')}
      
      
    },
        ### 2.0 Plot-Function ###
    .binomplot=function(image, ggtheme, theme, ...) {
        
        ### 2.1 Extraction of data ###
        data <- image$state$data
        label <- image$state$label
        mean <- image$state$mean
        std <- image$state$std
        meanHeight <- image$state$meanHeight

        meanColor <- "#7b9ee6"
        stdColor <- "red"

        ### 2.2 Create plot ###
        plot <- ggplot(data, aes(x=var, fill=group)) +
                ylab("P(X=r)") + 
                xlab("r") +
                scale_x_continuous() +
                ggtheme +
                geom_bar(aes(y=density),width=1,stat="identity",position = "identity",linetype="solid",alpha=0.7) +
                theme(legend.position="top") +
                guides(fill=guide_legend(title=label))
        if(self$options$mean){
            plot <- plot + geom_segment(aes(x=mean[1], y=0, xend=mean[1], yend=meanHeight[1]),linetype="longdash",colour = meanColor, size = 1,  alpha = 1) +
                geom_segment(aes(x=mean[2], y=0, xend=mean[2], yend=meanHeight[2]),linetype="longdash",colour = meanColor, size = 1,  alpha = 1) +
                geom_segment(aes(x=mean[3], y=0, xend=mean[3], yend=meanHeight[3]),linetype="longdash",colour = meanColor, size = 1,  alpha = 1) 
                
        }
        
        if(self$options$std){
            plot <- plot +
                        geom_segment(aes(x=mean[1]-(std[1]/2), y=meanHeight[1]+0.01, xend=mean[1]+(std[1]/2), yend=meanHeight[1]+0.01)
                            ,arrow=arrow(ends="both", angle = 90, length = unit(0.1,"cm")),colour = stdColor, size = 0.5,  alpha = 1) +
                        geom_segment(aes(x=mean[2]-(std[2]/2), y=meanHeight[2]+0.01, xend=mean[2]+(std[2]/2), yend=meanHeight[2]+0.01)
                            ,arrow=arrow(ends="both", angle = 90, length = unit(0.1,"cm")),colour = stdColor, size = 0.5,  alpha = 1) +
                        geom_segment(aes(x=mean[3]-(std[3]/2), y=meanHeight[3]+0.01, xend=mean[3]+(std[3]/2), yend=meanHeight[3]+0.01)
                            ,arrow=arrow(ends="both", angle = 90, length = unit(0.1,"cm")),colour = stdColor, size = 0.5,  alpha = 1) 
        # Below x-axis
        #geom_segment(aes(x=mean[2]-(std[2]/2), y=meanHeight[2] +0.01, xend=mean[2]+(std[2]/2), yend=meanHeight[2]+0.01) ,arrow=arrow(ends="both", angle = 90, length = unit(0.1,"cm")),colour = stdColor, size = 0.5,  alpha = 1)
        }
        
        print(plot)
        TRUE
    })
)
