require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# Get the observations in 1999-2008 and fips equals 24510, and select the columns that matters.
temp <- subset(NEI, year %in% c(1999:2008) & fips == "24510", select = c(Emissions, type, year))

# Sum Emissions group by year and type.
temp <- aggregate(Emissions ~ year + type, temp, sum)

# Rename
names(temp) <- c("year", "type", "Emissions")
temp$type <- as.factor(temp$type)

# Plot
ggplot(temp, aes(x = year, y = Emissions)) + 
    geom_line(aes(color = type)) +
    geom_point(aes(color = type), size = 3) +
    ylab("Emission") +
    xlab("Year") +
    aes(title = "Maryland's PM2.5 Emission over the years")

dev.copy(png, filename="plot3.png")
dev.off()