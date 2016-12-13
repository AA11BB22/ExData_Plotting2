NEI <- readRDS("summarySCC_PM25.rds")

# Get the observations in 1999, 2002, 2005, 2008, and select the columns that matters.
temp <- subset(NEI, year %in% c(1999, 2002, 2005, 2008), select = c(Emissions, year))

# Sum Emissions group by year.
temp <- aggregate(Emissions ~ year, temp, sum)

# Rename
names(temp) <- c("year", "Emissions")

# Plot
with(temp, plot(y = Emissions, x = year, type = "l"))
dev.copy(png, filename="plot1.png")
dev.off()
