NEI <- readRDS("summarySCC_PM25.rds")

# Get the observations in 1999-2008 and fips equals 24510, and select the columns that matters.
temp <- subset(NEI, year %in% c(1999:2008) & fips == "24510", select = c(Emissions, year))

# Sum Emissions group by year.
temp <- aggregate(Emissions ~ year, temp, sum)

# Rename
names(temp) <- c("year", "Emissions")

# Plot
with(temp, plot(y = Emissions, x = year, type = "l", 
                main = "Maryland's PM2.5 Emission over the years"))

dev.copy(png, filename="plot2.png")
dev.off()
