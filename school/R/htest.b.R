htestClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "htestClass",
  inherit = htestBase,
  private = list(
    .errorCheck = function(var,min,max,plot,message){
      tryCatch( { 
        res <- eval(parse(text = var))
        if(res<min||res>max||is.null(res)) {
          throw(message)
        }
      }, error = function(e) {
        plot$setVisible(visible=FALSE)
        jmvcore::reject(message)}
      )
      return(res)
    },
    .run = function() {
      ### 1.1 Preparation ###
          # The specification
          plot <- self$results$hypoPlot
          n <-private$.errorCheck(self$options$n,0,10000,plot,"Size must be between 0 and 10000")
          k <- private$.errorCheck(self$options$k,0,n,plot,"k must be between 0 and n")
          a <- private$.errorCheck(self$options$alpha,0,1,plot,"Alpha must be between 0 and 1")
          astr <- self$options$alpha
          p0 <- private$.errorCheck(self$options$p0,0,1,plot,'Probability must be between 0 and 1')
          p0str <- self$options$p0
          side <- self$options$side

      ### 1.2 Calculations ###
          #get scale length
          x <- 0:n
          # Calculation of the distribution density
          dbinom <- dbinom(x, n, p0)
          pbinom <- pbinom(x, n, p0) #cumulative
          
          lowerRej2 <- 0
          upperRej2 <- 0
          # Calculation of the rejection and acception area
          rejDensity <- c(rep(0,(n+1)))
          # Depending on the side set lower and upper Acception values
          switch(side, 
            leftSide={
              pValue <- pbinom(k, n, p0) 
              lowerAcc <- Position(function(x) x > a, pbinom)-1
              upperAcc <- n
              lowerRej <- 0
              upperRej <- lowerAcc - 1
              op <- "\u2265"
              cop <- "\u003C"
              cop2 <- "\u2264"  
              rejDensity <- c(dbinom[c(lowerRej:upperRej+1)],rep(0,(n-upperRej)))
            },
            rightSide={
              pValue <- 1-pbinom((k-1), n, p0) 
              lowerAcc <- 0
              upperAcc <- Position(function(x) x > (1-a), pbinom)-1
              lowerRej <- upperAcc + 1
              upperRej <- n
              op <- "\u2264"
              cop <- "\u003E"
              cop2 <- "\u2265"
              rejDensity <- c(rep(0,lowerRej),dbinom[c((lowerRej+1):(upperRej+1))])  
            },
            {
              pValue <- dbinom(k, n, p0) 
              lowerAcc <- Position(function(x) x > (a/2), pbinom)-1
              upperAcc <- Position(function(x) x > (1-(a/2)), pbinom)-1
              lowerRej <- 0
              upperRej <- lowerAcc -1
              lowerRej2 <- upperAcc +1
              upperRej2 <- n
              op <- "="
              cop <- "\u2260"
              cop2 <- "\u2260"
              rejDensity <- c(dbinom[c(lowerRej:(upperRej+1))],rep(0,(lowerRej2-upperRej-1)),dbinom[c((lowerRej2+1):(upperRej2+1))])   
            })

          mean <- n*p0
          meanHeight <- dbinom(round(n*p0,0), n, p0)
          std <- sqrt(n*p0*(1-p0))

      ### 1.3 Create Value Tables ###
          table <- self$results$get('table')
          table$deleteRows()
          table$addRow(rowKey="1", values=list(label="Error Probability",result=pValue))
          table$addRow(rowKey="2", values=list(label="Acception Area",result=jmvcore::format("[{},{}]", lowerAcc, upperAcc)))
          if(side=="bothSides"){
            table$addRow(rowKey="3", values=list(label="Rejection Area",result=jmvcore::format("[{},{}] \u222A [{},{}]", lowerRej, upperRej, lowerRej2, upperRej2)))
          }else{
            table$addRow(rowKey="3", values=list(label="Rejection Area",result=jmvcore::format("[{},{}]", lowerRej, upperRej)))
          }

      ### 1.4 Set Explanation ###
          aP <- round(a*100,3)
          todo <- jmvcore::format('
            Testing the H\u2080 hypothesis for a sample with unknown probability p, samplesize n and occurance k. 
            The test value is p\u2080 and \u03B1 is the level of significance, which defines the the rejection area. 
            A significance level of {} meaning that {} % of the values are in the rejection area.
            The Hypothesis H\u2080 is rejected if k is in the rejection area, which means that P(X {} k) is <\u03B1 = {}
            <br><br> H\u2080: p {} p\u2080 = {}
            <br> H\u2081: p {} p\u2080 = {} 
            <br><br> Error Probability= P(X {} k | p = p\u2080) = P(X {} {} | p = {})'
            , astr, aP, cop2, astr, op, p0str, cop, p0str, cop2, cop2, k, p0str)
          html <- self$results$todo
          html$setContent(todo)
       
      ### 1.5 Plot Preparation ###
          #all in one list -> so later we can do fill=group in ggplot
          density <- c(dbinom,rejDensity) 
          group <- c(rep("Acception Area",(n+1)),rep("Rejection Area",(n+1))) 
          # Frame Data
          plotData <- data.frame(var = x, density= density, group =group)
          # Set Data to Image 
          image <- self$results$hypoPlot
          image$setState(list(
            data=plotData, 
            label="", 
            mean = mean, 
            meanHeight = meanHeight, 
            std=std, 
            lowerAcc = lowerAcc,
            upperAcc = upperAcc,
            side = side))

      ##########errorplot
          #pstr <- self$options$p
          #tryCatch( { p <- eval(parse(text = self$options$p))}
          #  , error = function(e) {
          #  self$results$errorPlot$setVisible(visible=FALSE)
          #  jmvcore::reject('p must be between 0 and 1')}
          #)
          #dbinomP <- dbinom(x,n,p)
          #densityErr <- c(dbinom,dbinomP)
          #firstErrType <- c(rep(0,lowerRej),dbinom[c((lowerRej+1):(upperRej+1))])
          #secondErrType <- c(dbinomP[0:(lowerRej)],rep(0,(n-lowerRej+1)))
          #densityErr2 <- c(firstErrType,secondErrType)
          #mean2 <- n*p
          #std2 <- sqrt(n*p*(1-p))
          #
          #groupErr <- c(rep(paste("p0 = ",p0str),(n+1)),rep(rep(paste("p = ",pstr),(n+1))))
          #plotDataErr <- data.frame(var = x, densityErr= densityErr, densityErr2= densityErr2, group =groupErr) 
          #image <- self$results$errorPlot
          #image$setState(list(
          #  data=plotDataErr, 
          #  label="", 
          #  mean = mean,
          #  mean2 = mean2,
          #  meanHeight = meanHeight, 
          #  std=std, 
          #  std2=std2,
          #  lowerAcc = lowerAcc,
          #  upperAcc = upperAcc,
          #  side = side))
    },
    .hypoPlot = function(image, ggtheme, theme, ...){
        ### 2.1 Extraction of data ###
        data <- image$state$data
        mean <- image$state$mean
        meanHeight <- image$state$meanHeight
        std <- image$state$std
        k <- self$options$k
        n <- self$options$n
        lowerAcc <- image$state$lowerAcc
        upperAcc <- image$state$upperAcc
        side <- self$options$side
        kColor <- "red"
        if(self$options$scaleX){
          left <- max(c(-1,(mean-4*std)))
          right <- min(c(n+1,(mean+4*std)))
        }else{
          left <- -0.5
          right <- n+0.5
        }
        
        switch(side, 
          leftSide={
            linePos <- lowerAcc-0.5
            pos <- list(linePos = linePos, rLabPos = left+(linePos-left)/2, aLabPos = right-(right-linePos)/2)
          },
          rightSide={
            linePos <- upperAcc+0.5
            pos <- list (linePos = linePos, rLabPos = right-(right-linePos)/2, aLabPos = left+(linePos-left)/2)
          },
          {
            linePos <- lowerAcc-0.5
            linePos1 <- upperAcc+0.5
            pos <- list (linePos =linePos, linePos1 = linePos1, rLabPos = left+(linePos-left)/2.5, rLabPos1= right-(right-linePos1)/2.5, aLabPos = mean)
          })  
        
        ### 2.2 Create plot ###
        plot <- ggplot(data, aes(x=var,fill=group)) +
          ggtheme +
          geom_bar(aes(y=density),stat="identity",position = "identity",linetype="solid",alpha=1) +
          ylab("P(X=r)") + 
          xlab("r") +
          theme(legend.position="top",axis.title.x = element_text(hjust=1),axis.title.y = element_text(hjust=1)) +
          guides(fill=guide_legend(title=image$state$label)) +
          coord_cartesian( clip="off") +
          scale_x_continuous(limits=c(left,right))
        #get fill colors 
        g <- ggplot_build(plot)
        colors <- unlist(unique(g$data[[1]]["fill"]))
        
        #set Acception Lines and labels 
        plot <- plot + 
          geom_segment(aes(x=pos$linePos, y=0, xend=pos$linePos, yend=meanHeight),linetype="longdash",colour ="black", size = 0.5,  alpha = 1, show.legend = FALSE) +
          annotate(geom="text", x=pos$rLabPos, y=meanHeight+(meanHeight/15), label="Reject Hypothesis",color=colors[2],size=5) +
          annotate(geom="text", x=pos$aLabPos, y=meanHeight+(meanHeight/15), label="Accept Hypothesis",color=colors[1],size=5)
        if(side == "bothSides"){
          plot <- plot +
            geom_segment(aes(x=pos$linePos1, y=0, xend=pos$linePos1, yend=meanHeight),linetype="longdash",colour ="black", size = 0.5,  alpha = 1, show.legend = FALSE) +
            annotate(geom="text", x=pos$rLabPos1, y=meanHeight+(meanHeight/15), label="Reject Hypothesis",color=colors[2],size=5)
        }
        #set KLine
        if(self$options$kLine){
          plot <- plot + 
            geom_segment(aes(x=k, y=0, xend=k, yend=meanHeight),linetype="longdash",colour = kColor, size = 0.5,  alpha = 1, show.legend = FALSE) +
            geom_text(x=k, y=-(meanHeight/5), label="k",color=kColor,size=6) 
        }
         
        print(plot)
        TRUE

    }
    #,.errorPlot = function(image, ggtheme, theme, ...){
        #### 2.1 Extraction of data ###
        #data <- image$state$data
        #label <- image$state$label
        #mean <- image$state$mean
        #mean2 <- image$state$mean2
        #std <- image$state$std
        #std2 <- image$state$std2
        #meanHeight <- image$state$meanHeight
        #n <- self$options$n
        #k <- self$options$k
        #group <- data$group
        #lowerAcc <- image$state$lowerAcc
        #upperAcc <- image$state$upperAcc
        #side <- self$options$side
        #meanColor <- "#7b9ee6"
        #stdColor <- "red"
        #kColor <- "red"
        #if(self$options$scaleX){
        #  left <- max(c(-1,min((mean-4*std),(mean2-4*std2))))
        #  right <- min(c(n+1,max((mean+4*std),(mean2+4*std2))))
        #}else{
        #  left <- -0.5
        #  right <- n+0.5
        #}
        #
        #
        #switch(side, 
        #  leftSide={
        #    linePos <- lowerAcc-0.5
        #    pos <- list(linePos = linePos, rLabPos = left+(linePos-left)/2, aLabPos = right-(right-linePos)/2)
        #  },
        #  rightSide={
        #    linePos <- upperAcc+0.5
        #    pos <- list (linePos = linePos, rLabPos = right-(right-linePos)/2, aLabPos = left+(linePos-left)/2)
        #  },
        #  {
        #    linePos <- lowerAcc-0.5
        #    linePos1 <- upperAcc+0.5
        #    pos <- list (linePos =linePos, linePos1 = linePos1, rLabPos = left+(linePos-left)/2.5, rLabPos1= right-(right-linePos1)/2.5, aLabPos = mean)
        #  })  
        #
        #### 2.2 Create plot ###
        #plot <- ggplot(data, aes(x=var)) +
        #  ggtheme +
        #  geom_bar(aes(y=densityErr2,fill=group),stat="identity",position = "identity",linetype="solid",alpha=0.9  ) +
        #  geom_bar(aes(y=densityErr,color=group),stat="identity",position = "identity",linetype="solid", fill="white",alpha=0, show.legend=FALSE) +
        #  ylab("P(X=r)") + 
        #  xlab("r") +
        #  theme(legend.position="top",axis.title.x = element_text(hjust=1),axis.title.y = element_text(hjust=1)) +
        #  guides(fill=guide_legend(title=label)) +
        #  coord_cartesian( clip="off") +
        #  scale_x_continuous(limits=c(left,right)) +
        #  geom_segment(aes(x=pos$linePos, y=0, xend=pos$linePos, yend=meanHeight),linetype="longdash",colour ="black", size = 0.5,  alpha = 1, show.legend = FALSE)#+
        #
        #print(plot)
        #TRUE
    #}
  )
)
